import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nex_haptic_method_channel.dart';

abstract class NexHapticPlatform extends PlatformInterface {
  /// Constructs a NexHapticPlatform.
  NexHapticPlatform() : super(token: _token);

  static final Object _token = Object();

  static NexHapticPlatform _instance = MethodChannelNexHaptic();

  /// The default instance of [NexHapticPlatform] to use.
  ///
  /// Defaults to [MethodChannelNexHaptic].
  static NexHapticPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NexHapticPlatform] when
  /// they register themselves.
  static set instance(NexHapticPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get the platform version
  Future<String?> getPlatformVersion();

  /// Trigger haptic feedback on the platform with specified type and intensity level
  Future<void> triggerHapticFeedback({
    required String type,
  });
}
