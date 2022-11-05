# thttpd container image

[![Publish container images](https://github.com/ananthb/thttpd-container/actions/workflows/containers.yml/badge.svg)](https://github.com/ananthb/thttpd-container/actions/workflows/containers.yml)

Produces a minimal OCI container image containing a static [thttpd](https://acme.com/software/thttpd/) binary.
thttpd is configured to serve out of the /srv directory.

![thttpd](https://acme.com/software/thttpd/logos/thttpd_powered_1.gif)

Thanks to [ACME Laboratories](https://acme.com/software/thttpd/) for thttpd.

Source Hut Mirror - [git.sr.ht/~ananth/thttpd-container](https://git.sr.ht/~ananth/thttpd-container)

## Usage

The image can be used in two ways:
1. Mount static content to /srv and run the image.

        podman run --rm -v ./static:/srv -p 8080:8080 ghcr.io/ananthb/thttpd-container

    The container listens for HTTP connections on port 8080.


2. Extend this image:

    [Hugo](https://gohugo.io) static site example

       FROM docker.io/klakegg/hugo:0.83.1-ext-onbuild AS hugo

       FROM ghcr.io/ananthb/thttpd-container
       COPY --from=hugo /target /srv/
       
    The hugo container generates a hugo site and stores it in the /target directory. 
    In the second stage, those static files are copied to the thttpd-container image and placed in the /srv directory.
       
---

MIT Licensed, see [LICENSE](./LICENSE).
Copyright (c) 2021, & 2022 Ananth Bhaskararaman

