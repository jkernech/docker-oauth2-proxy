FROM golang:alpine as builder

RUN apk add --no-cache git && \
    go get -d github.com/bitly/oauth2_proxy && \
    CGO_ENABLED=0 GOOS=linux go build -a --ldflags '-extldflags "-static"' github.com/bitly/oauth2_proxy

FROM alpine

RUN apk add --no-cache ca-certificates openssl
COPY --from=builder /go/oauth2_proxy /bin/oauth2_proxy

ENTRYPOINT ["/bin/oauth2_proxy"]
