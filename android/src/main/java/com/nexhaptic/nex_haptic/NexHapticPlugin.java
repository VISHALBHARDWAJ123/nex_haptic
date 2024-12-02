package com.nexhaptic.nex_haptic;

import android.content.Context;
import android.os.Build;
import android.os.VibrationEffect;
import android.os.Vibrator;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * NexHapticPlugin
 */
public class NexHapticPlugin implements FlutterPlugin, MethodCallHandler {

    private MethodChannel channel;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "nex_haptic");
        channel.setMethodCallHandler(this);

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + Build.VERSION.RELEASE);
        } else if (call.method.equals("triggerHapticFeedback")) {
            String vibrationType = call.argument("type"); // Get vibration type from arguments
            // Get vibration level (intensity) from arguments
            triggerHapticFeedback(vibrationType, context);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private void triggerHapticFeedback(String vibrationType, Context context) {
        if (context == null) return; // Ensure context is available

        Vibrator vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);

        if (vibrator != null && vibrator.hasVibrator()) {
/*
            int intensity = getVibrationIntensity(vibrationLevel); // Get intensity based on level
*/

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                switch (vibrationType) {
                    case "short":
                        vibrator.vibrate(VibrationEffect.createOneShot(50, getVibrationIntensity("low")));
                        break;
                    case "long":
                        vibrator.vibrate(VibrationEffect.createOneShot(300, getVibrationIntensity("high")));
                        break;
                    case "pattern":
                        long[] pattern = {0, 100, 200, 300}; // Wait 0ms, vibrate 100ms, pause 200ms, vibrate 300ms
                        vibrator.vibrate(VibrationEffect.createWaveform(pattern, -1)); // No repeat
                        break;
                    default:
                        vibrator.vibrate(VibrationEffect.createOneShot(100, getVibrationIntensity("default")));
                }
            } else {
                switch (vibrationType) {
                    case "short":
                        vibrator.vibrate(50);
                        break;
                    case "long":
                        vibrator.vibrate(300);
                        break;
                    case "pattern":
                        long[] pattern = {0, 100, 200, 300};
                        vibrator.vibrate(pattern, -1); // No repeat
                        break;
                    default:
                        vibrator.vibrate(100);
                }
            }
        }
    }

    // This method maps the vibration level to the appropriate intensity value
    private int getVibrationIntensity(String vibrationLevel) {
        int intensity = VibrationEffect.DEFAULT_AMPLITUDE; // Default intensity

        if (vibrationLevel != null) {
            switch (vibrationLevel) {
                case "low":
                    intensity = 30; // Low intensity (range 0 to 255)
                    break;
                case "medium":
                    intensity = 100; // Medium intensity
                    break;
                case "high":
                    intensity = 255; // High intensity
                    break;
                default:
                    intensity = VibrationEffect.DEFAULT_AMPLITUDE;
                    break;
            }
        }
        return intensity;
    }
}
