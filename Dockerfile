# trunk-ignore-all(checkov/CKV_DOCKER_2)
# trunk-ignore-all(checkov/CKV_DOCKER_3)
# trunk-ignore-all(checkov/CKV2_DOCKER_1)
# trunk-ignore-all(hadolint/DL3008)
# trunk-ignore-all(terrascan/AC_DOCKER_0002)
# trunk-ignore-all(trivy/DS002)
# trunk-ignore-all(trivy/DS014)
# trunk-ignore-all(trivy/DS026)

FROM maven:3.8.6-eclipse-temurin-11 as builder

# Install git and unzip
RUN apt-get update && \
    apt-get install --no-install-recommends -y unzip=6.0-26ubuntu3.1 git=1:2.34.1-1ubuntu1.9 && \
    rm -rf /var/lib/apt/lists/*

# Create directories and set working directory
RUN mkdir -p /opt/client /opt/src
WORKDIR /opt

# Copy source code and client files to the container
COPY src src/
COPY client client/

# Download and install Saxon-HE 11.4 Java version
RUN wget --progress=dot:giga -O SaxonHE11-4J.zip https://sourceforge.net/projects/saxon/files/Saxon-HE/11/Java/SaxonHE11-4J.zip/download && \
    unzip SaxonHE11-4J.zip && \
    ls /opt

# install schxslt
WORKDIR /opt/client/schxslt
RUN git clone https://github.com/schxslt/SchXslt2-Core .

WORKDIR /opt/client

# add saxon11-xslt script to path
COPY web/saxon11-xslt /usr/local/bin

# build and test (set SKIP_TESTS to "true" to skip tests)
ARG SKIP_TESTS=false

RUN chmod +x /usr/local/bin/saxon11-xslt && \
    ./createSchemas.sh && \
    mvn package

WORKDIR /opt
COPY pom.xml pom.xml
RUN if [ "${SKIP_TESTS}" = "true" ] ; then echo "Skipping tests" ; else mvn test ; fi


FROM php:7.4-apache
ENV DEBIAN_FRONTEND=noninteractive
ARG WORKDIR

RUN a2enmod rewrite

# Add the Debian Bullseye package sources
RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list && \
    echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list && \
    echo 'deb http://deb.debian.org/debian bullseye-updates main' >> /etc/apt/sources.list && \
    echo 'deb-src http://deb.debian.org/debian bullseye-updates main' >> /etc/apt/sources.list && \
    echo 'deb https://security.debian.org/debian-security bullseye-security main' >> /etc/apt/sources.list

# Update and upgrade packages
RUN apt-get -y update && \
    apt-get -y upgrade && apt-get -y autoremove && \
    rm -rf /var/cache/apk/*

RUN rm /etc/apt/preferences.d/no-debian-php

# Install necessary dependencies for running the application
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        openjdk-11-jre libgbm-dev libxkbcommon-x11-0 libgtk-3-0 locales \
        php7.4 libzip-dev unzip cron tzdata sudo locales gcc wget python3 && \
    rm -rf /var/cache/apk/*

# Install the zip extension for PHP
RUN docker-php-ext-install zip

RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen

# Install Node.js
RUN wget --progress=dot:giga https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
RUN mkdir -p /usr/local/lib/nodejs && tar -xJf node-v16.18.0-linux-x64.tar.xz -C /usr/local/lib/nodejs && rm node-v16.18.0-linux-x64.tar.xz
ENV PATH "/usr/local/lib/nodejs/node-v16.18.0-linux-x64/bin:$PATH"
ENV LC_ALL "en_US.UTF-8"
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"

# Install npm packages
RUN npm install npm@9.5.1 --location=global
# trunk-ignore(hadolint/DL3059)
RUN npm install multer@1.4.5-lts.1
# trunk-ignore(hadolint/DL3059)
RUN npm install @daisy/ace@1.3.2 --location=global
ENV ACE_PATH "/usr/local/lib/nodejs/node-v16.18.0-linux-x64/bin/ace"

RUN cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime && \
    echo "Europe/Stockholm" > /etc/timezone

# Install the cron job
COPY web/docker_cron /etc/cron.d/docker_cron
RUN chmod 0644 /etc/cron.d/docker_cron && \
    crontab /etc/cron.d/docker_cron

COPY web/cron_job.sh /root/cron_job.sh
RUN chmod +x /root/cron_job.sh

COPY web/prepare_env.sh /root/prepare_env.sh
RUN chmod +x /root/prepare_env.sh

# trunk-ignore(hadolint/DL3059)
RUN sed -i 's/^exec /\n\n\/root\/prepare_env.sh\n\nexport LANG=en_US.UTF-8\n\nservice cron start\n\nexec /' /usr/local/bin/apache2-foreground

# Copy the web files to the container
COPY web/bin/ /var/www/bin/
COPY web/include/ /var/www/include/
COPY web/src/ /var/www/html/

# Copy the client files to the container
COPY --from=builder /opt/client/target/NordicValidator-*-jar-with-dependencies.jar /var/www/bin/NordicValidator.jar

RUN mkdir -p /var/www/.config /var/www/.local && \
    chown www-data:www-data /var/www/.config /var/www/.local

HEALTHCHECK --interval=10s --timeout=8s --start-period=15s \
            CMD http_proxy="" https_proxy="" wget --quiet --tries=1 http://${HOST-0.0.0.0}:${PORT:-80}/v1/ || exit 1
