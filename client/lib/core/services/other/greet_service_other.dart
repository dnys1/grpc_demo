import '../../models/models.dart';
import '../greet_service_base.dart';

class GreetService extends GreetServiceBase<Null> {
  void init({Null channel, GreetServiceClient client}) {
    throw UnsupportedError('This platform is not supported.');
  }
}
