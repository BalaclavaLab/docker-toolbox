FROM alpine:3.7

ENV PAGER='busybox less'

RUN apk add --no-cache \
         bash \
         bash-completion \
         jq \
         git \
         vim \
         curl \
         redis \
         groff \
         tcpdump \
         bind-tools \
         ca-certificates \
         ruby \
         python \
    && gem install redis --version 3.3.3 --no-document \
    && apk add --no-cache --virtual .aws-build-deps py-pip \
    && pip install awscli \
    && apk del .aws-build-deps \
    && curl -fSL https://github.com/projectcalico/calicoctl/releases/download/v1.6.3/calicoctl -o /usr/bin/calicoctl \
    && chmod +x /usr/bin/calicoctl \
    && curl -fSL http://download.redis.io/redis-stable/src/redis-trib.rb -o /usr/bin/redis-trib \
    && chmod +x /usr/bin/redis-trib \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it

COPY bashrc /root/.bashrc

ENTRYPOINT ["/bin/bash"]

CMD ["-c", "trap : TERM INT; sleep 316224000 & wait" ]
