FROM ubuntu:20.04

# default is 'vircadia'
ARG REPO=hasbegun
# default is 'master'
ARG BRANCH=docker

ARG WEB_SDK_VER=vircadia-web-sdk-2022.1.1.tgz

RUN apt update && apt install -y git curl
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && \
    bash ./nodesource_setup.sh && \
    apt install nodejs && \
    rm ./nodesource_setup.sh

RUN npm install -g @vue/cli@latest

# checkout repo
RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    git clone --depth 1 --branch ${BRANCH} https://github.com/${REPO}/vircadia-web.git

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    git clone --depth 1 --branch ${BRANCH} https://github.com/${REPO}/vircadia-web-sdk.git

RUN cd /usr/local/src/vircadia-web-sdk && \
    npm install && npm run build && npm pack && \
    cp /usr/local/src/vircadia-web-sdk/${WEB_SDK_VER} /usr/local/src/vircadia-web/${WEB_SDK_VER} && \
    tar zxvf ${WEB_SDK_VER} && npm link

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
