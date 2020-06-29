import 'dart:async';

import 'package:grpc/grpc_connection_interface.dart';

import '../models/models.dart';

abstract class GreetServiceBase<C extends ClientChannelBase> {
  C channel;
  GreetServiceClient client;

  void init({C channel, GreetServiceClient client});

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

  Stream<String> greetEveryone(Stream<List<String>> stream) {
    final response = client.greetEveryone(stream.map((name) {
      final firstName = name[0];
      final lastName = name[1];

      final greeting = Greeting()
        ..firstName = firstName
        ..lastName = lastName;
      final request = GreetEveryoneRequest()..greeting = greeting;

      return request;
    }));
    return response.map((res) => res.result);
  }
}
