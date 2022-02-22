FROM node:16-bullseye-slim AS cypress-build
RUN apt-get update
RUN apt-get install -y git vim jq zip unzip gcc
RUN apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
RUN apt-get install -y libgtk-3-dev 
RUN git clone https://github.com/cypress-io/cypress.git
WORKDIR cypress
RUN git checkout tags/v9.3.1 -b build-branch
RUN yarn install
RUN yarn binary-build --version "$(jq -r .version < package.json)" 2>&1 > ./build.docker.log && yarn binary-zip
RUN cp -a /tmp/cypress-build/linux/build/Cypress /Cypress
