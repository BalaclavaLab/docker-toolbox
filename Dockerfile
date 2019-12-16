FROM alpine:3.10

ENV PAGER='busybox less'

RUN apk add --no-cache \
         bash \
         bash-completion \
         jq \
         git \
         vim \
         curl \
         groff \
         redis \
         tcpdump \
         bind-tools \
         mariadb-backup \
         ca-certificates \
         python \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing lbzip2 \
    && apk add --no-cache --virtual .aws-build-deps py-pip \
    && pip install awscli \
    && apk del .aws-build-deps \
    && curl -fSL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it

COPY bashrc /root/.bashrc

ENTRYPOINT ["/bin/bash"]

CMD ["-c", "trap : TERM INT; sleep 316224000 & wait" ]
