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
}
