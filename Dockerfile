FROM node:18-alpine AS builder

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /home/node/app
COPY . /home/node/app
RUN npm ci --include=dev && npm run build-only

FROM nginx:1.21-alpine

COPY --from=builder /home/node/app/dist /usr/share/nginx/html

EXPOSE 80
