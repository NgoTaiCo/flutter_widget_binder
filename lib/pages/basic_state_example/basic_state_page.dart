import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class BasicStatePage extends StatefulWidget {
  const BasicStatePage({super.key});

  @override
  State<BasicStatePage> createState() => _BasicStatePageState();
}

class _BasicStatePageState extends State<BasicStatePage> {
  final _counter = StateNotifier<int>(0);

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic State Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Basic State Management Example'),
            const SizedBox(height: 20),
            WidgetBinder<int>(
              state: _counter,
              builder: (context, value) => Text(
                'Counter: $value',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            ElevatedButton(
              onPressed: () => _counter.setValue(_counter.value + 1),
              child: const Text('Increment Counter'),
            ),
            ElevatedButton(
              onPressed: () => _counter.setValue(_counter.value - 1),
              child: const Text('Decrement Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
