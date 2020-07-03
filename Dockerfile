FROM golang:1.14.4

WORKDIR $GOPATH/src/github.com/dnys1/grpc_demo

COPY go.mod go.sum ./
RUN go mod download

COPY server/ ./server/

WORKDIR $GOPATH/src/github.com/dnys1/grpc_demo/server

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /server .

FROM alpine:3.12.0

COPY --from=0 /server /usr/local/bin/server

EXPOSE 50051

ENTRYPOINT ["/usr/local/bin/server"]