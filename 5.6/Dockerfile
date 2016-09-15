FROM wodby/drupal-php:5.6
MAINTAINER Ginal

# Sshd config
RUN apk --update add openssh \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:dk39COWm5bxuDr4r2oi99" | chpasswd \
  && rm -rf /var/cache/apk/*

EXPOSE 22

## Supevisor config
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.0

RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

COPY supervisord.conf /etc/supervisord.conf

COPY .profile /root/
COPY boot_tasks.sh /root/
RUN mkdir -p /var/log/supervisor

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
