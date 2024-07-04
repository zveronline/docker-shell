FROM alpine:3.20

ENV LANG=ru_RU.UTF-8 \
LANGUAGE=ru_RU.UTF-8 \
TZ=Europe/Moscow \
ROOT_PASS=qwe123

ADD config /config
ADD entrypoint.sh /entrypoint.sh
RUN apk add --update gzip curl rsync git wget screen procps bash nano openssh tzdata sudo htop ca-certificates openssl coreutils mysql-client postgresql-client python3 \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata \
&& echo -n root:$ROOT_PASS | chpasswd \
&& chmod 755 /entrypoint.sh \
&& chmod -R 700 /config \
&& chmod 600 /config/host/sshd_config \
&& cp /config/profile /root/.profile \
&& mkdir -p /root/.ssh

VOLUME ["/root/.ssh", "/etc/ssh"]
CMD ["/usr/sbin/sshd", "-D"]
ENTRYPOINT ["/entrypoint.sh"]
