FROM docker.io/library/alpine:3.14.2 AS build
ARG thttpd_version
RUN test -n "$thttpd_version"
RUN apk add --no-cache gcc musl-dev make 
RUN wget http://www.acme.com/software/thttpd/thttpd-${thttpd_version}.tar.gz
RUN tar xzf thttpd-${thttpd_version}.tar.gz
RUN mv /thttpd-${thttpd_version} /thttpd
WORKDIR /thttpd
RUN ./configure
RUN make -j CCOPT='-O2 -s -static' thttpd
  
FROM scratch
USER 1000
COPY --from=build /thttpd/thttpd .
WORKDIR /srv
VOLUME /srv
EXPOSE 8080
ENTRYPOINT ["/thttpd", "-D", "-d", "/srv", "-p", "8080"]
CMD ["-l", "-", "-M", "60"]