# puppeteer

[![dockeri.co](https://dockeri.co/image/ultimaphoenix/puppeteer)](https://hub.docker.com/r/ultimaphoenix/puppeteer)

[![Docker Automated build](https://img.shields.io/docker/automated/ultimaphoenix/puppeteer.svg)](https://hub.docker.com/r/ultimaphoenix/puppeteer/)

Base docker image for [Puppeteer](https://developers.google.com/web/tools/puppeteer).

## Usage

You should launch the browser with the following arguments:

```js
const browser = await puppeteer.launch({
  args: ['--no-sandbox', '--disable-setuid-sandbox']
});
```

Assuming that your app has a structure like this:
```
my-app/
├── .dockerignore
├── Dockerfile
├── package.json
├── puppeteer.js
└── README.md
```
Include the following lines in your `Dockerfile`:
```
FROM ultimaphoenix/puppeteer

COPY package.json /home/puppeteer
COPY puppeteer.js /home/puppeteer
RUN chown -R puppeteer:puppeteer /home/puppeteer/package.json \
    && chown -R puppeteer:puppeteer /home/puppeteer/puppeteer.js

# Run everything after as non-privileged user.
USER puppeteer
WORKDIR /home/puppeteer

RUN npm install

CMD ["node", "puppeteer.js"]
```

## What to know to run Puppeteer on Docker

>By default, Docker runs a container with a `/dev/shm` shared memory space 64MB.
This is [typically too small](https://github.com/c0b/chrome-in-docker/issues/1) for Chrome
and will cause Chrome to crash when rendering large pages. To fix, run the container with
`docker run --shm-size=1gb` to increase the size of `/dev/shm`. Since Chrome 65, this is no
longer necessary. Instead, launch the browser with the `--disable-dev-shm-usage` flag:
>
>```js
>const browser = await puppeteer.launch({
>  args: ['--disable-dev-shm-usage']
>});
>```
>
>This will write shared memory files into `/tmp` instead of `/dev/shm`. See [crbug.com/736452](https://bugs.chromium.org/p/chromium/issues/detail?id=736452) for more details.
>
> &mdash; The [official Puppeteer documentation](https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#tips)

If you encounter other errors not mentioned here, please refer to the [official Puppeteer documentation](https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md).
