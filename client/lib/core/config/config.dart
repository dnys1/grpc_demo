import 'package:flutter/foundation.dart';

class Config {
  static final host = '0.tcp.ngrok.io';
  // static final host = '127.0.0.1';
  static final port = kIsWeb ? 8080 : 12105;
  // static final port = kIsWeb ? 8080 : 50051;
}
