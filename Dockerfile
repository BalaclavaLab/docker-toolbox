FROM alpine:3.15

ENV PAGER='busybox less'

ARG TARGETARCH

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
         aws-cli \
         bind-tools \
         ca-certificates \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing pixz \
    && curl -fSL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/$TARGETARCH/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it

COPY bashrc /root/.bashrc

ENTRYPOINT ["/bin/bash"]

CMD ["-c", "trap : TERM INT; sleep infinity & wait" ]
