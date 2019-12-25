FROM node:13-slim

LABEL name="puppeter"
LABEL maintainer="UltimaPhoenix"
LABEL version="1.0.0"
LABEL description="Base docker puppeteer image"

RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get update && apt-get install -y --no-install-recommends \
        libx11-6 libx11-dev libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 \
        libxext6 libxi6 libxtst6 libglib2.0-0 libnss3 libcups2 \
        libxss1 libxrandr2 libasound2 libpangocairo-1.0 \
        libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 \
        ./google-chrome-stable_current_amd64.deb && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove
RUN rm google-chrome-stable_current_amd64.deb

CMD /bin/bash


