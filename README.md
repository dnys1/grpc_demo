# gRPC Demo

gRPC protocol with Go server with Flutter client

### Start Server

To start the server:

```
go run server/main.go
```

And if running the Flutter Web client, also start the Envoy proxy:

```
./start_proxy.sh
```

### Start Client

To start the client:

```
cd client && flutter run
```