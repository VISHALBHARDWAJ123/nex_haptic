import 'dart:developer';

import 'package:flutter/services.dart';

class NexHaptic {
  static const MethodChannel _channel = MethodChannel('nex_haptic');

  // Enum for vibration types
  static const String short = 'short';
  static const String long = 'long';
  static const String pattern = 'pattern';

  // Enum for vibration levels
  static const String low = 'low';
  static const String medium = 'medium';
  static const String high = 'high';

  // Method to trigger haptic feedback
  Future<void> triggerHapticFeedback({
    required String vibrationType,
  }) async {
    try {
      await _channel.invokeMethod('triggerHapticFeedback', {
        'type': vibrationType,
      });
    } on PlatformException catch (e) {
      log("Failed to trigger haptic feedback: '${e.message}'.");
    }
  }

  // Method to get platform version (just an example, can be used for debugging)
  static Future<String?> getPlatformVersion() async {
    try {
      final String? version = await _channel.invokeMethod('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      log("Failed to get platform version: '${e.message}'.");
      return null;
    }
  }
}
