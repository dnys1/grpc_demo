protoc -I proto \
    --go_out=server/model/greetpb \
    --go_opt=paths=source_relative \
    --go-grpc_out=server/model/greetpb \
    --go-grpc_opt=paths=source_relative \
    --dart_out=grpc:client/lib/core/models/greet \
    proto/greet.proto