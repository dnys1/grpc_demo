FROM alpine:3.12

COPY ./build/server .
RUN chmod +x ./server

EXPOSE 50051

CMD ["./server"]