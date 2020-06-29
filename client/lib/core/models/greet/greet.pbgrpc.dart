///
//  Generated code. Do not modify.
//  source: greet.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'greet.pb.dart' as $0;
export 'greet.pb.dart';

class GreetServiceClient extends $grpc.Client {
  static final _$greet = $grpc.ClientMethod<$0.GreetRequest, $0.GreetResponse>(
      '/greet.GreetService/Greet',
      ($0.GreetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GreetResponse.fromBuffer(value));
  static final _$greetMany =
      $grpc.ClientMethod<$0.GreetManyRequest, $0.GreetManyResponse>(
          '/greet.GreetService/GreetMany',
          ($0.GreetManyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GreetManyResponse.fromBuffer(value));
  static final _$longGreet =
      $grpc.ClientMethod<$0.LongGreetRequest, $0.LongGreetResponse>(
          '/greet.GreetService/LongGreet',
          ($0.LongGreetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.LongGreetResponse.fromBuffer(value));
  static final _$greetEveryone =
      $grpc.ClientMethod<$0.GreetEveryoneRequest, $0.GreetEveryoneResponse>(
          '/greet.GreetService/GreetEveryone',
          ($0.GreetEveryoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GreetEveryoneResponse.fromBuffer(value));

  GreetServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.GreetResponse> greet($0.GreetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$greet, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.GreetManyResponse> greetMany(
      $0.GreetManyRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$greetMany, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseFuture<$0.LongGreetResponse> longGreet(
      $async.Stream<$0.LongGreetRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$longGreet, request, options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.GreetEveryoneResponse> greetEveryone(
      $async.Stream<$0.GreetEveryoneRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$greetEveryone, request, options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class GreetServiceBase extends $grpc.Service {
  $core.String get $name => 'greet.GreetService';

  GreetServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GreetRequest, $0.GreetResponse>(
        'Greet',
        greet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GreetRequest.fromBuffer(value),
        ($0.GreetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GreetManyRequest, $0.GreetManyResponse>(
        'GreetMany',
        greetMany_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GreetManyRequest.fromBuffer(value),
        ($0.GreetManyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LongGreetRequest, $0.LongGreetResponse>(
        'LongGreet',
        longGreet,
        true,
        false,
        ($core.List<$core.int> value) => $0.LongGreetRequest.fromBuffer(value),
        ($0.LongGreetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GreetEveryoneRequest, $0.GreetEveryoneResponse>(
            'GreetEveryone',
            greetEveryone,
            true,
            true,
            ($core.List<$core.int> value) =>
                $0.GreetEveryoneRequest.fromBuffer(value),
            ($0.GreetEveryoneResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GreetResponse> greet_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GreetRequest> request) async {
    return greet(call, await request);
  }

  $async.Stream<$0.GreetManyResponse> greetMany_Pre($grpc.ServiceCall call,
      $async.Future<$0.GreetManyRequest> request) async* {
    yield* greetMany(call, await request);
  }

  $async.Future<$0.GreetResponse> greet(
      $grpc.ServiceCall call, $0.GreetRequest request);
  $async.Stream<$0.GreetManyResponse> greetMany(
      $grpc.ServiceCall call, $0.GreetManyRequest request);
  $async.Future<$0.LongGreetResponse> longGreet(
      $grpc.ServiceCall call, $async.Stream<$0.LongGreetRequest> request);
  $async.Stream<$0.GreetEveryoneResponse> greetEveryone(
      $grpc.ServiceCall call, $async.Stream<$0.GreetEveryoneRequest> request);
}
