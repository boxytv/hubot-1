FROM node:6.2.0

RUN mkdir /opt/bot \
    && useradd -ms /bin/bash node \
    && chown -R node /opt/bot

ENV HUBOT_VERSION 2.18.0

RUN npm install -g \
    hubot@${HUBOT_VERSION} \
    yo@1.7.0 \
    generator-hubot@0.3.1

USER node
WORKDIR /opt/bot

ADD bot /opt/bot

COPY bot/scripts/bindings.js /opt/bot/scripts/
COPY bot/scripts/azure.coffee /opt/bot/scripts/

RUN npm install paperspace-node

CMD ["./bin/hubot", "--adapter", "slack"]
