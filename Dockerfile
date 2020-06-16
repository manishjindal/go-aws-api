FROM golang:1.14 as builder

ARG VERSION

WORKDIR /usr/go-aws-api

COPY . .
RUN make build

# final image
FROM alpine:3.11.5

RUN apk add --no-cache ca-certificates && \
    update-ca-certificates

COPY --from=builder /usr/go-aws-api/build/go-aws-api /bin/go-aws-api


ENTRYPOINT ["/bin/go-aws-api"]