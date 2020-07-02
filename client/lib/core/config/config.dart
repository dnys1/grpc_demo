import 'package:flutter/foundation.dart';
import 'package:flutter_is_emulator/flutter_is_emulator.dart';

class Config {
  static Future<String> get host async {
    if (await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator) {
      return simulatorHost;
    } else {
      return deviceHost;
    }
  }

  static final deviceHost = '2.tcp.ngrok.io';
  static final simulatorHost = '127.0.0.1';

  static Future<int> get port async {
    if (await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator) {
      return simulatorPort;
    } else {
      return devicePort;
    }
  }

  static final devicePort = kIsWeb ? 8080 : 16939;
  static final simulatorPort = kIsWeb ? 8080 : 50051;
}
