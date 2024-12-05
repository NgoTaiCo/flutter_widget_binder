import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class UIStateBindingPage extends StatefulWidget {
  const UIStateBindingPage({super.key});

  @override
  State<UIStateBindingPage> createState() => _UIStateBindingPageState();
}

class _UIStateBindingPageState extends State<UIStateBindingPage> {
  final _textState = StateNotifier<String>('Initial Value');

  @override
  void dispose() {
    _textState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI State Binding Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('UI Binding Example'),
            const SizedBox(height: 20),
            WidgetBinder<String>(
              state: _textState,
              builder: (context, value) => Text(
                'Current Text: $value',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            ElevatedButton(
              onPressed: () => _textState.setValue('Updated Value'),
              child: const Text('Update Text'),
            ),
            ElevatedButton(
              onPressed: () => _textState.setValue('Reset Value'),
              child: const Text('Reset Text'),
            ),
          ],
        ),
      ),
    );
  }
}
