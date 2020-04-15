FROM python:3.8
MAINTAINER hxc

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    supervisor \
&& rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY deploy.conf /etc/supervisor/conf.d/deploy.conf

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
COPY ./ /root/tornado_docker
WORKDIR /root/tornado_docker

EXPOSE 8080 8081 8082 8083
ENTRYPOINT ["/usr/bin/supervisord"]
