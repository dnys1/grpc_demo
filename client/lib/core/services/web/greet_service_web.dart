import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

import '../../models/models.dart';
import '../greet_service_base.dart';

class GreetService extends GreetServiceBase<GrpcWebClientChannel> {
  @override
  void init({GrpcWebClientChannel channel, GreetServiceClient client}) {
    this.channel =
        channel ?? GrpcWebClientChannel.xhr(Uri.parse('http://127.0.0.1:8080'));
    this.client = client ??
        GreetServiceClient(
          this.channel,
          options: CallOptions(
            timeout: const Duration(seconds: 30),
          ),
        );
  }

  @override
  Future<String> longGreet(Stream<List<String>> stream) {
    throw UnsupportedError('Client-side streaming not yet supported on web.');
  }

  @override
  Stream<String> greetEveryone(Stream<List<String>> stream) {
    throw UnsupportedError('Bidirectional streaming not yet supported on web.');
  }
}
