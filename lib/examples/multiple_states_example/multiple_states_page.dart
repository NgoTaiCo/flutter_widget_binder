import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class MultipleStatesPage extends StatefulWidget {
  const MultipleStatesPage({super.key});

  @override
  State<MultipleStatesPage> createState() => _MultipleStatesPageState();
}

class _MultipleStatesPageState extends State<MultipleStatesPage> {
  final counter1 = StateNotifier<int>(0);
  final counter2 = StateNotifier<int>(10);

  @override
  void dispose() {
    counter1.dispose();
    counter2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final combinedState = MultipleStatesNotifier([counter1, counter2]);
    return Scaffold(
      appBar: AppBar(title: const Text('Combined State Example')),
      body: Center(
        child: WidgetBinder(
          state: combinedState,
          builder: (context, snapshot) {
            final values = snapshot;
            final sum = values[0] + values[1];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter 1: ${values[0]}'),
                Text('Counter 2: ${values[1]}'),
                Text('Sum: $sum'),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () => counter1.setValue(counter1.value + 1),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () => counter2.setValue(counter2.value + 2),
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
