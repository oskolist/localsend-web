FROM node:24-bookworm AS builder
WORKDIR /data
RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run generate


FROM nginx:latest
COPY --from=builder /data/.output/public /usr/share/nginx/html
EXPOSE 80
