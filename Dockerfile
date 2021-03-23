FROM golang:1.15.7 as builder
RUN mkdir -p /opt/centrifugo
ADD . /opt/centrifugo
WORKDIR /opt/centrifugo
RUN make build

FROM alpine:3.10

RUN apk --no-cache upgrade && apk --no-cache add ca-certificates

COPY --from=builder /opt/centrifugo/centrifugo /usr/local/bin/centrifugo 

WORKDIR /centrifugo

CMD ["centrifugo"]
