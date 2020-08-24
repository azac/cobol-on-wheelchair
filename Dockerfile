FROM ubuntu:trusty AS builder
WORKDIR /cow
RUN apt-get update && apt-get install -qy open-cobol
COPY . /cow
RUN ./downhill.sh

FROM ubuntu:trusty
RUN apt-get update && apt-get install -qy apache2 libcob1
COPY --from=builder /cow /cow
EXPOSE 80
CMD [ "-D", "FOREGROUND", "-f", "/cow/apache.conf"]
ENTRYPOINT [ "/usr/sbin/apachectl" ]
