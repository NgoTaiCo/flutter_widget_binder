import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/examples/undoable_state_example/model/user.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

class UndoableStatePage extends StatefulWidget {
  const UndoableStatePage({super.key});

  @override
  State<UndoableStatePage> createState() => _UndoableStatePageState();
}

class _UndoableStatePageState extends State<UndoableStatePage> {
  static List names = ['Jerry', 'Mark', 'John', 'Henry', 'William', "Jonathan"];
  final userNotifier = UndoableStateNotifier<User>(
    User(name: names[0], age: 25),
  );

  @override
  void dispose() {
    userNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Undo/Redo Example')),
      body: WidgetBinder(
        state: userNotifier,
        builder: (context, snapshot) {
          final user = snapshot;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
                Text('Age: ${user.age}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => userNotifier.update(
                    user.copyWith(name: (names.toList()..shuffle()).first),
                  ),
                  child: const Text('Change Name'),
                ),
                ElevatedButton(
                  onPressed: () => userNotifier.update(
                    user.copyWith(age: user.age + 1),
                  ),
                  child: const Text('Increase Age'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: userNotifier.undo,
                      child: const Text('Undo'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: userNotifier.redo,
                      child: const Text('Redo'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
