FROM alpine:3.7

RUN apk add --no-cache \
         bash \
         curl \
         redis \
         tcpdump \
         bind-tools \
         ca-certificates \
         ruby \
    && gem install redis --no-document \
    && curl -fSL http://download.redis.io/redis-stable/src/redis-trib.rb -o /usr/bin/redis-trib \
    && chmod +x /usr/bin/redis-trib

CMD [ "/bin/bash", "-c", "trap : TERM INT; sleep 316224000 & wait" ]
