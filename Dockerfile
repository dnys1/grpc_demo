FROM golang:1.14.4-alpine

WORKDIR /go/src/github.com/dnys1/grpc_demo

COPY go.mod .
COPY go.sum .
COPY server ./server/

RUN cd server && go install

EXPOSE 50051

CMD ["server"]