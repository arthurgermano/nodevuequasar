FROM ubuntu:18.04

# adding proxy privoxy
RUN export https_proxy=http://localhost:8118 && export http_proxy=http://localhost:8118

# update packages
RUN apt update && apt upgrade -y

# Installing updated wget
RUN apt install -y wget

# Installing bash
RUN apt install build-essential -y

RUN echo "https_proxy=http://localhost:8118" >> /etc/wgetrc
RUN echo "http_proxy=http://localhost:8118" >> /etc/wgetrc

# Installing NVM
RUN wget -qO- http://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
&& export NVM_DIR="$HOME/.nvm" \
&& [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  \
&& [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
&& nvm install 11 \
&& nvm use 11 \
&& npm config set proxy http://localhost:8118 && npm config set https-proxy http://localhost:8118 \
&& npm config set registry http://registry.npmjs.org \
&& npm config set unsafe-perm true \
&& npm install -g @vue/cli \
&& npm install -g @quasar/cli \
&& npm install -g serve \
&& npm install -g workbox-cli \
&& npm install -g pm2

WORKDIR /app

EXPOSE 3000
EXPOSE 8080
EXPOSE 5000

MAINTAINER Arthur Jose Germano <email@email.com>
