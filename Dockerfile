FROM alpine:3.7

ENV PAGER='busybox less'

RUN apk add --no-cache \
         bash \
         jq \
         curl \
         redis \
         groff \
         tcpdump \
         bind-tools \
         ca-certificates \
         ruby \
         python \
    && gem install redis --no-document \
    && apk add --no-cache --virtual .aws-build-deps py-pip \
    && pip install awscli \
    && apk del .aws-build-deps \
    && curl -fSL https://github.com/projectcalico/calicoctl/releases/download/v1.6.3/calicoctl -o /usr/bin/calicoctl\
    && chmod +x /usr/bin/calicoctl
    && curl -fSL http://download.redis.io/redis-stable/src/redis-trib.rb -o /usr/bin/redis-trib \
    && chmod +x /usr/bin/redis-trib

CMD [ "/bin/bash", "-c", "trap : TERM INT; sleep 316224000 & wait" ]
