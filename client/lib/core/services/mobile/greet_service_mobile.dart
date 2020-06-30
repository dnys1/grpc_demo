import 'package:grpc/grpc.dart';

import '../../config/config.dart';
import '../../models/models.dart';
import '../greet_service_base.dart';

class GreetService extends GreetServiceBase<ClientChannel> {
  @override
  void init({ClientChannel channel, GreetServiceClient client}) {
    this.channel = channel ??
        ClientChannel(
          Config.host,
          port: Config.port,
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
}
