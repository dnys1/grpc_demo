package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"time"

	"github.com/dnys1/grpc_demo/server/model/greetpb"
	"google.golang.org/grpc"
)

type server struct{}

func (*server) Greet(ctx context.Context, req *greetpb.GreetRequest) (*greetpb.GreetResponse, error) {
	log.Printf("Greet invoked with %v\n", req)

	firstName := req.GetGreeting().GetFirstName()
	lastName := req.GetGreeting().GetLastName()

	if firstName == "" || lastName == "" {
		return nil, fmt.Errorf("Missing first name or last name")
	}

	return &greetpb.GreetResponse{
		Result: fmt.Sprintf("Hello, %s %s", firstName, lastName),
	}, nil
}

func (*server) GreetMany(req *greetpb.GreetManyRequest, stream greetpb.GreetService_GreetManyServer) error {
	fmt.Printf("GreetMany invoked with %v\n", req)

	firstName := req.GetGreeting().GetFirstName()
	lastName := req.GetGreeting().GetLastName()

	if firstName == "" || lastName == "" {
		return fmt.Errorf("Missing first name or last name")
	}

	for i := 0; i < 10; i++ {
		result := fmt.Sprintf("Hello, %s %s, number %d", firstName, lastName, i)
		res := &greetpb.GreetManyResponse{
			Result: result,
		}
		stream.Send(res)
		time.Sleep(1000 * time.Millisecond)
	}

	stream.Send(&greetpb.GreetManyResponse{
		Result: "End of stream",
	})

	return nil
}

func newServer() *server {
	return &server{}
}

func main() {
	// 50051 is default gRPC port
	lis, err := net.Listen("tcp", "0.0.0.0:50051")
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer()
	greetpb.RegisterGreetServiceServer(grpcServer, newServer())

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
