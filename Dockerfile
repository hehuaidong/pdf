FROM node:10.15.2-alpine

# 安装 Chromium (72)。从 alpine/v3.9 版本库中下载
RUN apk update && apk upgrade && 
    echo @v3.9 http://dl-cdn.alpinelinux.org/alpine/v3.9/community >> /etc/apk/repositories && 
    echo @v3.9 http://dl-cdn.alpinelinux.org/alpine/v3.9/main >> /etc/apk/repositories && 
    apk add --no-cache 
      freetype@v3.9 
      chromium@v3.9 
      harfbuzz@v3.9 
      nss@v3.9

# 安装 Puppeteer 时不让它自动下载 Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
# 选择 Chromium 72 对应的 Puppeteer 版本
RUN yarn add puppeteer@1.11.0

# 添加用户
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser 
    && mkdir -p /home/pptruser/Downloads 
    && chown -R pptruser:pptruser /home/pptruser

# 添加 cjk 字体以支持中文
COPY NotoSansCJK-Regular.ttc  /usr/share/fonts/TTF

USER pptruser
