FROM centos:7
MAINTAINER <github@tonylee.hk>

RUN yum update -y && yum install -y unzip
RUN yum install -y java-1.8.0-openjdk-devel
RUN yum reinstall -y glibc-common

ENV LANG en.UTF-8

RUN curl -O https://downloads.typesafe.com/typesafe-activator/1.3.12/typesafe-activator-1.3.12.zip
RUN unzip typesafe-activator-1.3.12.zip -d / && rm typesafe-activator-1.3.12.zip && chmod a+x /activator-dist-1.3.12/bin/activator
ENV PATH $PATH:/activator-dist-1.3.12/bin

COPY ./PlayPrefetcher /tmp/PlayPrefetcher
RUN cd /tmp/PlayPrefetcher ; activator compile
RUN rm -rf /tmp/PlayPrefetcher

EXPOSE 8888 9000

RUN mkdir /app
WORKDIR /app

CMD ["activator", "run"]
