FROM maven:3.8.6-eclipse-temurin-11 as builder
RUN apt update
RUN apt install -y unzip
RUN mkdir -p /opt
WORKDIR /opt
RUN mkdir -p client
RUN mkdir -p src
ADD src src/
ADD client client/

RUN curl -O -J -L https://sourceforge.net/projects/saxon/files/Saxon-HE/11/Java/SaxonHE11-4J.zip/download
RUN unzip SaxonHE11-4J.zip
RUN ls /opt

WORKDIR /opt/client

# install schxslt
RUN wget https://github.com/schxslt/schxslt/releases/download/v1.9.4/schxslt-1.9.4-xslt-only.zip \
    && unzip schxslt-*.zip -d schxslt \
    && mv schxslt/schxslt-*/* schxslt \
    && rm schxslt-*.zip

ADD web/saxon9-xslt /usr/local/bin
RUN chmod +x /usr/local/bin/saxon9-xslt
RUN ./createSchemas.sh
RUN mvn package

FROM php:7.4-apache
ENV DEBIAN_FRONTEND=noninteractive
ARG WORKDIR

RUN a2enmod rewrite

RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list

RUN echo 'deb http://deb.debian.org/debian bullseye-updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian bullseye-updates main' >> /etc/apt/sources.list

RUN echo 'deb https://security.debian.org/debian-security bullseye-security main' >> /etc/apt/sources.list

RUN apt -y update
RUN apt -y upgrade
RUN apt -y dist-upgrade
RUN apt -y autoremove

RUN rm /etc/apt/preferences.d/no-debian-php

RUN apt -y install openjdk-11-jre libgbm-dev libxkbcommon-x11-0 libgtk-3-0 locales \
        php7.4 libzip-dev unzip cron tzdata sudo locales gcc wget python3 && rm -rf /var/cache/apk/*
RUN docker-php-ext-install zip

RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen

RUN locale-gen

RUN wget https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
RUN mkdir -p /usr/local/lib/nodejs && tar -xJf node-v16.18.0-linux-x64.tar.xz -C /usr/local/lib/nodejs && rm node-v16.18.0-linux-x64.tar.xz
ENV PATH "/usr/local/lib/nodejs/node-v16.18.0-linux-x64/bin:$PATH"
RUN npm install npm@8.12.2 --location=global
RUN npm install multer@1.4.5-lts.1
RUN npm install @daisy/ace --location=global

RUN cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
RUN echo "Europe/Stockholm" > /etc/timezone

ADD web/docker_cron /etc/cron.d/docker_cron
RUN chmod 0644 /etc/cron.d/docker_cron
RUN crontab /etc/cron.d/docker_cron

ADD web/cron_job.sh /root/cron_job.sh
RUN chmod +x /root/cron_job.sh

ADD web/prepare_env.sh /root/prepare_env.sh
RUN chmod +x /root/prepare_env.sh

RUN sed -i 's/^exec /\n\n\/root\/prepare_env.sh\n\nexport LANG=en_US.UTF-8\n\nservice cron start\n\nexec /' /usr/local/bin/apache2-foreground

ADD web/bin/ /var/www/bin/
ADD web/include/ /var/www/include/
ADD web/src/ /var/www/html/

COPY --from=builder /opt/client/target/NordicValidator-*-jar-with-dependencies.jar /var/www/bin/NordicValidator.jar

RUN mkdir -p /var/www/.config
RUN chown www-data:www-data /var/www/.config
RUN mkdir -p /var/www/.local
RUN chown www-data:www-data /var/www/.local
