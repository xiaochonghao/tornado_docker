FROM python:3.8
MAINTAINER hxc

RUN apt-get update && apt-get install -y \
    supervisor \
&& rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY deploy.conf /etc/supervisor/conf.d/deploy.conf

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
COPY ./ /root/free_tornado
WORKDIR /root/free_tornado

EXPOSE 8080 8081 8082 8083
ENTRYPOINT ["/usr/bin/supervisord"]
