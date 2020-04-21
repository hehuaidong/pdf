# FROM node:10-alpine
FROM node:10.15.2-alpine


# Installs latest Chromium (72) package.
RUN apk update && apk upgrade &&  echo @v3.9 http://dl-cdn.alpinelinux.org/alpine/v3.9/community >> /etc/apk/repositories && echo @v3.9 http://dl-cdn.alpinelinux.org/alpine/v3.9/main >> /etc/apk/repositories &&  apk add --no-cache freetype@v3.9 chromium@v3.9 harfbuzz@v3.9 nss@v3.9


# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Puppeteer v1.9.0 works with Chromium 71.
# Puppeteer v1.10.0 | v1.11.0 works with Chromium 72.
# Puppeteer v1.12.x works with Chromium 73.
# RUN yarn add puppeteer@1.9.0
RUN yarn add puppeteer@1.11.0


# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser
    # && chown -R pptruser:pptruser /app

# Add cjk font
COPY NotoSansCJK-Regular.ttc  /usr/share/fonts/TTF
COPY ./ /tmp
RUN npm i
# Run everything after as non-privileged user.
USER pptruser
EXPOSE 3000
