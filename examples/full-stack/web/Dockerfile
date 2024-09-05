FROM node:20-alpine3.17

ARG FRACTAL_WEB_VERSION


ENV NODE_MAJOR_VERSION=20

RUN wget -qO- "https://github.com/fractal-analytics-platform/fractal-web/releases/download/v${FRACTAL_WEB_VERSION}/node-${NODE_MAJOR_VERSION}-fractal-web-v${FRACTAL_WEB_VERSION}.tar.gz" | tar -xz

ENV FRACTAL_SERVER_HOST=http://slurm:8000
ENV PUBLIC_FRACTAL_VIZARR_VIEWER_URL=http://localhost:3000/vizarr
ENV PUBLIC_FRACTAL_ADMIN_SUPPORT_EMAIL=
ENV PUBLIC_OAUTH_CLIENT_NAME=
ENV AUTH_COOKIE_DOMAIN=
ENV LOG_FILE=fractal-web.log
ENV FRACTAL_API_V1_MODE=exclude
ENV ORIGIN=http://localhost:5173
ENV PORT=5173

# Running
CMD ["node", "build"]
