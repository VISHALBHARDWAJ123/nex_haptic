/*
import Flutter
import UIKit

public class NexHapticPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "nex_haptic", binaryMessenger: registrar.messenger())
    let instance = NexHapticPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
*/
import Flutter
import UIKit
import AudioToolbox

public class NexHapticPlugin: NSObject, FlutterPlugin {

    private var impactFeedbackGenerator: UIImpactFeedbackGenerator?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "nex_haptic", binaryMessenger: registrar.messenger())
        let instance = NexHapticPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getPlatformVersion" {
            result("iOS " + UIDevice.current.systemVersion)
        } else if call.method == "triggerHapticFeedback" {
            if let args = call.arguments as? [String: Any],
               let vibrationType = args["type"] as? String{
                triggerHapticFeedback(vibrationType: vibrationType)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func triggerHapticFeedback(vibrationType: String) {
        // Adjust haptic feedback strength based on vibration level
        let intensity: UIImpactFeedbackGenerator.FeedbackStyle

        switch vibrationType {
        case "short":
            intensity = .light
        case "pattern":
            intensity = .medium
        case "long":
            intensity = .heavy
        default:
            intensity = .light
        }

        // Trigger vibration based on vibration type
        switch vibrationType {
        case "short":
            impactFeedbackGenerator = UIImpactFeedbackGenerator(style: intensity)
            impactFeedbackGenerator?.prepare()
            impactFeedbackGenerator?.impactOccurred()
        case "long":
            impactFeedbackGenerator = UIImpactFeedbackGenerator(style: intensity)
            impactFeedbackGenerator?.prepare()
            impactFeedbackGenerator?.impactOccurred()
            // You can extend it with custom logic if needed for long vibrations
        case "pattern":
            // On iOS, we can't directly create complex patterns like Android.
            // But we can simulate a pattern with a sequence of haptic feedback events.
            impactFeedbackGenerator = UIImpactFeedbackGenerator(style: intensity)
            impactFeedbackGenerator?.prepare()
            impactFeedbackGenerator?.impactOccurred()
            // You could call it several times to simulate a pattern
            // For example:
            impactFeedbackGenerator?.impactOccurred()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.impactFeedbackGenerator?.impactOccurred()
            }
        default:
            impactFeedbackGenerator = UIImpactFeedbackGenerator(style: intensity)
            impactFeedbackGenerator?.prepare()
            impactFeedbackGenerator?.impactOccurred()
        }
    }
}
