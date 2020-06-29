import 'dart:async';

import 'package:async/async.dart';
import 'package:client/core/models/greet/greet.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class GreetService {
  ClientChannel channel;
  GreetServiceClient client;

  GreetService({ClientChannel channel, GreetServiceClient client}) {
    this.channel = channel ??
        ClientChannel(
          '127.0.0.1',
          port: 50051,
          options:
              const ChannelOptions(credentials: ChannelCredentials.insecure()),
        );
    this.client = client ??
        GreetServiceClient(
          this.channel,
          options: CallOptions(
            timeout: const Duration(seconds: 30),
          ),
        );
  }

  Future<String> greetOnce(String firstName, String lastName) async {
    final greeting = Greeting()
      ..firstName = firstName
      ..lastName = lastName;
    final request = GreetRequest()..greeting = greeting;

    final response = await client.greet(request);
    return response.result;
  }

  Stream<String> greetMany(String firstName, String lastName) {
    final greeting = Greeting()
      ..firstName = firstName
      ..lastName = lastName;
    final request = GreetManyRequest()..greeting = greeting;

    return client.greetMany(request).map((resp) => resp.result);
  }

  Future<String> longGreet(Stream<List<String>> stream) async {
    final response = await client.longGreet(stream.map((name) {
      final firstName = name[0];
      final lastName = name[1];

      final greeting = Greeting()
        ..firstName = firstName
        ..lastName = lastName;
      final request = LongGreetRequest()..greeting = greeting;

      return request;
    }));
    return response.result;
  }
}
