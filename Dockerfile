FROM alpine:3.9 as pbzip2

ENV PBZIP2_VER=1.1.13

RUN apk add --no-cache build-base bzip2-dev curl \
    && curl -fSL https://launchpad.net/pbzip2/1.1/${PBZIP2_VER}/+download/pbzip2-${PBZIP2_VER}.tar.gz -o pbzip2.tar.gz \
    && tar zxf pbzip2.tar.gz \
    && cd pbzip2-${PBZIP2_VER} \
    && make \
    && cp pbzip2 /usr/local/bin

FROM alpine:3.9

ENV PAGER='busybox less'

RUN apk add --no-cache \
         bash \
         bash-completion \
         jq \
         git \
         vim \
         curl \
         groff \
         tcpdump \
         bind-tools \
         ca-certificates \
         python \
    && apk add --no-cache --virtual .aws-build-deps py-pip \
    && pip install awscli \
    && apk del .aws-build-deps \
    && curl -fSL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
    && chmod +x /usr/bin/kubectl \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it

COPY bashrc /root/.bashrc
COPY --from=pbzip2 /usr/local/bin/pbzip2 /usr/bin/pbzip2
COPY --from=redis:5.0.3-alpine /usr/local/bin/redis-* /usr/local/bin/

ENTRYPOINT ["/bin/bash"]

CMD ["-c", "trap : TERM INT; sleep 316224000 & wait" ]
