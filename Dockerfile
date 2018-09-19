# Use a multistage build to first build the migrator using maven. Then
# copy the artifacts into a final image which exposes the port and
# starts the pipeline.

# Build the pipeline first
FROM maven:3.5-jdk-8 as builder
ADD . /usr/src/nordic-epub3-dtbook-migrator
WORKDIR /usr/src/nordic-epub3-dtbook-migrator
RUN mvn clean package

# then use the build artifacts to create an image where the pipeline is installed
FROM daisyorg/pipeline-assembly
LABEL maintainer="Norwegian library of talking books and braille (http://www.nlb.no/)"
COPY --from=builder /usr/src/nordic-epub3-dtbook-migrator/target/nordic-epub3-dtbook-migrator-*.jar /opt/daisy-pipeline2/modules/
ENV PIPELINE2_WS_LOCALFS=false \
    PIPELINE2_WS_AUTHENTICATION=true \
    PIPELINE2_WS_AUTHENTICATION_KEY=clientid \
    PIPELINE2_WS_AUTHENTICATION_SECRET=sekret
EXPOSE 8181
# for the healthcheck use PIPELINE2_HOST if defined. Otherwise use localhost
HEALTHCHECK --interval=30s --timeout=10s --start-period=1m CMD curl --fail http://${PIPELINE2_WS_HOST-localhost}:${PIPELINE2_WS_PORT:-8181}/${PIPELINE2_WS_PATH:-ws}/alive || exit 1
ENTRYPOINT ["/opt/daisy-pipeline2/bin/pipeline2"]
