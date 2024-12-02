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
