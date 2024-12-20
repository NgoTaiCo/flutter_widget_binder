import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class DummyPageA extends StatefulWidget {
  const DummyPageA({super.key});

  @override
  State<DummyPageA> createState() => _DummyPageAState();
}

class _DummyPageAState extends State<DummyPageA> {
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
        title: const Text("dummy page A"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  _checkerNotifier.setValue(!_checkerNotifier.value),
              child: const Text('Reverse value from home page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/dummy-page-b'),
              child: const Text('Go to Page B'),
            ),
          ],
        ),
      ),
    );
  }
}
