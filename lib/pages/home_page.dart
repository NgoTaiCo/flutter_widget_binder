import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkerNotifier = AppState().sharedCheckerNotifier;

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetBinder(
              state: checkerNotifier,
              builder: (context, result) => Text(
                "result from dummy page: $result",
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/basic'),
              child: const Text('Test Basic State Management'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/ui-binding'),
              child: const Text('Test UI State Binding'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/async'),
              child: const Text('Test Async State Management'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/dummy-page-a'),
              child: const Text('Test App State'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/multiple-states'),
              child: const Text('Test Multiple States'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/deboucing-state'),
              child: const Text('Test Deboucing States'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/undoable-state'),
              child: const Text('Test Undoable States'),
            ),
          ],
        ),
      ),
    );
  }
}
