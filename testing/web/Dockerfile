FROM node:20-alpine3.17

RUN apk add bash git

ARG FRACTAL_SERVER_HOST
WORKDIR /app

# Get fractal-web
ADD config.env .
COPY web/get_fractal_web.sh .
RUN bash get_fractal_web.sh

# moving to repository directory
WORKDIR /app/fractal-web/

ENV FRACTAL_SERVER_HOST=${FRACTAL_SERVER_HOST}
ENV AUTH_COOKIE_NAME=fastapiusersauth
ENV PUBLIC_FRACTAL_ADMIN_SUPPORT_EMAIL=
ENV PUBLIC_OAUTH_CLIENT_NAME=
ENV AUTH_COOKIE_DOMAIN=localhost
ENV LOG_FILE=fractal-web.log
ENV AUTH_COOKIE_PATH=/
ENV AUTH_COOKIE_MAX_AGE=1800
ENV AUTH_COOKIE_SAME_SITE=lax
ENV AUTH_COOKIE_HTTP_ONLY=true
ENV FRACTAL_API_V1_MODE=exclude
ENV ORIGIN=http://localhost:5173
ENV PORT=5173

# Installing dependencies and building
RUN npm install
RUN npm run build

# Running
CMD ["node", "build"]