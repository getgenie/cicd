FROM node:lts-alpine@sha256:1a9a71ea86aad332aa7740316d4111ee1bd4e890df47d3b5eff3e5bded3b3d10 as base

RUN apk add dumb-init
RUN apk add curl

WORKDIR /usr/app
COPY --chown=node:node package*.json .
EXPOSE 3000
HEALTHCHECK --interval=15s --timeout=10s --retries=2 CMD curl -f http://localhost:3000/pool/ || exit 1

FROM base as production
ENV NODE_ENV=production
RUN npm ci --only=production
COPY --chown=node:node . .
USER node
CMD ["dumb-init", "node", "server.js"]

FROM base as development
ENV NODE_ENV=development
RUN npm i -g nodemon && npm ci
COPY --chown=node:node . .
USER node
CMD ["dumb-init", "nodemon", "server.js"]