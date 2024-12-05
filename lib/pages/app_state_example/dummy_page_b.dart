import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/app_state.dart';

class DummyPageB extends StatefulWidget {
  const DummyPageB({super.key});

  @override
  State<DummyPageB> createState() => _DummyPageBState();
}

class _DummyPageBState extends State<DummyPageB> {
  final _checkerNotifier = AppState().sharedCheckerNotifier;

  @override
  void dispose() {
    _checkerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("dummy page B"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _checkerNotifier.setValue(!_checkerNotifier.value),
              child: const Text('Reverse value from home page'),
            ),
          ],
        ),
      ),
    );
  }
}
