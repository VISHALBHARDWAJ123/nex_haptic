# nex_haptic

This cross-platform plugin provides haptic feedback for both Android and iOS devices, allowing you to trigger three types of vibration feedback:

- **Short Vibration**: A quick, brief vibration for simple interactions.
- **Long Vibration**: A longer, sustained vibration for more pronounced feedback.
- **Patterned Vibration**: Customizable vibration patterns, allowing you to create more complex feedback sequences.

The plugin offers an easy-to-use API for both Android and iOS, making it ideal for apps that require tactile feedback to enhance user interactions. Simply call the desired vibration type, and the plugin will handle the rest on both platforms.

## Installation

Add `nex_haptic` to your `pubspec.yaml` file:

```yaml
dependencies:
  nex_haptic: ^0.0.1
```

Then, run:

```bash
flutter pub get
```


## Usage

Here's how to use the `nex_haptic`:

### How to use

```dart
import 'package:flutter/material.dart';
import 'package:nex_haptic/nex_haptic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';
  final _nexHapticPlugin = NexHaptic();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nex Haptic Example'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              InkWell(
                  onTap: () {
                    _nexHapticPlugin.triggerHapticFeedback(
                      vibrationType: NexHaptic.long,
                    );
                  },
                  child: const Text('Vibration Type: Long')),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    _nexHapticPlugin.triggerHapticFeedback(
                      vibrationType: NexHaptic.short,
                    );
                  },
                  child: const Text('Vibration Type: Short')),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    _nexHapticPlugin.triggerHapticFeedback(
                      vibrationType: NexHaptic.pattern,
                    );
                  },
                  child: const Text('Vibration Type: Pattern')),
            ],
          ),
        ),
      ),
    );
  }
}


```


