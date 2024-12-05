import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class AsyncStatePage extends StatefulWidget {
  const AsyncStatePage({super.key});

  @override
  State<AsyncStatePage> createState() => _AsyncStatePageState();
}

class _AsyncStatePageState extends State<AsyncStatePage> {
  final _asyncState = AsyncStateNotifier<String>('Initial Async Value');

  Future<String> fetchApiCall() async {
    _asyncState.update((_) => "Loading");
    await Future.delayed(const Duration(seconds: 3));

    return 'Data from API';
  }

  @override
  void dispose() {
    _asyncState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async State Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Async State Management Example'),
            const SizedBox(height: 20),
            WidgetBinder<String>(
              state: _asyncState,
              builder: (context, value) => Text(
                'Async State: $value',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _asyncState.updateAsync((_) => fetchApiCall());
              },
              child: const Text('Fetch Data from API'),
            ),
            ElevatedButton(
              onPressed: () => _asyncState.reset('Reset Async Value'),
              child: const Text('Reset State'),
            ),
          ],
        ),
      ),
    );
  }
}
