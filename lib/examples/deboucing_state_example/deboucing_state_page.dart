import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class DeboucingStatePage extends StatefulWidget {
  const DeboucingStatePage({super.key});

  @override
  State<DeboucingStatePage> createState() => _DeboucingStatePageState();
}

class _DeboucingStatePageState extends State<DeboucingStatePage> {
  final _sliderValueManager = DebounceStateNotifier<double>(0.0);

  @override
  void dispose() {
    _sliderValueManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debounced Slider Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetBinder(
            state: _sliderValueManager,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Text(
                    "Value: ${snapshot.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Slider(
                    value: snapshot,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (value) {
                      _sliderValueManager.update(value, debounceDuration: Duration.zero);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
