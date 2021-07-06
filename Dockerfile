# Use a multistage build to first build the migrator using maven. Then
# copy the artifacts into a final image which exposes the port and
# starts the pipeline.

# Build the pipeline first
FROM maven:3.6-jdk-11 as builder
ADD . /usr/src/nordic-epub3-dtbook-migrator
WORKDIR /usr/src/nordic-epub3-dtbook-migrator
RUN mv .mvn ~/.m2  # configure global maven settings.xml

# TODO: remove -DskipTests when we have
#       a working version of the 2020-1 validator.
RUN mvn clean package -DskipTests

RUN rm -f /usr/src/nordic-epub3-dtbook-migrator/target/nordic-epub3-dtbook-migrator-*-doc.jar
RUN rm -f /usr/src/nordic-epub3-dtbook-migrator/target/nordic-epub3-dtbook-migrator-*-xprocdoc.jar

# then use the build artifacts to create an image where the pipeline is installed
FROM daisyorg/pipeline-assembly:latest
LABEL maintainer="Norwegian library of talking books and braille (http://www.nlb.no/)"
COPY --from=builder /usr/src/nordic-epub3-dtbook-migrator/target/nordic-epub3-dtbook-migrator-*.jar /opt/daisy-pipeline2/system/common/
ENV PIPELINE2_WS_LOCALFS=false \
    PIPELINE2_WS_AUTHENTICATION=false \
    PIPELINE2_WS_AUTHENTICATION_KEY=clientid \
    PIPELINE2_WS_AUTHENTICATION_SECRET=sekret
EXPOSE 8181

# for the healthcheck use PIPELINE2_HOST if defined. Otherwise use localhost
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=30s --timeout=10s --start-period=1m CMD http_proxy="" https_proxy="" HTTP_PROXY="" HTTPS_PROXY="" curl --fail http://${PIPELINE2_WS_HOST-localhost}:${PIPELINE2_WS_PORT:-8181}/${PIPELINE2_WS_PATH:-ws}/alive || exit 1

ADD docker-entrypoint.sh /opt/daisy-pipeline2/docker-entrypoint.sh
ENTRYPOINT ["/opt/daisy-pipeline2/docker-entrypoint.sh"]
