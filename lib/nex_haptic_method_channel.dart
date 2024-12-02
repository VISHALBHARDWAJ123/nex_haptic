import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nex_haptic_platform_interface.dart';

/// An implementation of [NexHapticPlatform] that uses method channels.
class MethodChannelNexHaptic extends NexHapticPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nex_haptic');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> triggerHapticFeedback({
    required String type,
  }) async {
    await methodChannel.invokeMethod<String>('triggerHapticFeedback', {
      'type': type,
    });
  }
}
