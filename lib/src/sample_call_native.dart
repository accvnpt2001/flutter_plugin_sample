import 'dart:async';

import 'package:flutter/services.dart';

class SampleCallNativeFlutter {
  // method channel in plugin to call function from native
  static const MethodChannel _channel = const MethodChannel('sample_plugin_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
