FROM ubuntu:20.04 as web-base

RUN apt update && apt install -y git curl
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && \
    bash ./nodesource_setup.sh && \
    apt install nodejs && \
    rm ./nodesource_setup.sh

FROM web-base as web-sdk-builder
# checkout repo
RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    git clone --depth 1 --branch master https://github.com/vircadia/vircadia-web-sdk.git

RUN cd /usr/local/src/vircadia-web-sdk && \
    npm install && npm run build && npm pack

FROM web-base
RUN npm install -g @vue/cli@latest
RUN npm install -g @quasar/cli
ARG WEB_SDK_VER=vircadia-web-sdk-2022.1.1.tgz

# default is 'vircadia'
ARG REPO=hasbegun
# default is 'master'
ARG BRANCH=docker

# checkout repo
RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    git clone --depth 1 --branch ${BRANCH} https://github.com/${REPO}/vircadia-web.git

COPY --from=web-sdk-builder /usr/local/src/vircadia-web-sdk/${WEB_SDK_VER} /usr/local/src/vircadia-web/
RUN cd /usr/local/src/vircadia-web && \
    tar zxvf ${WEB_SDK_VER} && cd package && npm link
RUN cd /usr/local/src/vircadia-web && \
    npm install && npm run build

ENV USER=cadia
ENV VIRCADIAWEB=vircadia-web

# Add a user for the server to run under
RUN adduser --disabled-password --gecos 'vircadia user' ${USER}

WORKDIR /home/${USER}
USER ${USER}:${USER}
RUN mkdir -p /home/${USER}/${VIRCADIAWEB}/log
COPY --chown=${USER}:${USER} ./files/run-vircadia-web.sh /home/${USER}/

EXPOSE 8090
ENTRYPOINT [ "/home/cadia/run-vircadia-web.sh" ]
