import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sample_plugin_flutter_method_channel.dart';

abstract class SamplePluginFlutterPlatform extends PlatformInterface {
  /// Constructs a SamplePluginFlutterPlatform.
  SamplePluginFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static SamplePluginFlutterPlatform _instance = MethodChannelSamplePluginFlutter();

  /// The default instance of [SamplePluginFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelSamplePluginFlutter].
  static SamplePluginFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SamplePluginFlutterPlatform] when
  /// they register themselves.
  static set instance(SamplePluginFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
