import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sample_plugin_flutter_platform_interface.dart';

/// An implementation of [SamplePluginFlutterPlatform] that uses method channels.
class MethodChannelSamplePluginFlutter extends SamplePluginFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sample_plugin_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
