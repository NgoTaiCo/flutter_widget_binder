import 'package:flutter/material.dart';
import 'package:flutter_widget_binder/pages/async_state_example/async_state_page.dart';
import 'package:flutter_widget_binder/pages/basic_state_example/basic_state_page.dart';
import 'package:flutter_widget_binder/pages/deboucing_state_example/deboucing_state_page.dart';
import 'package:flutter_widget_binder/pages/app_state_example/dummy_page_a.dart';
import 'package:flutter_widget_binder/pages/app_state_example/dummy_page_b.dart';
import 'package:flutter_widget_binder/pages/home_page.dart';
import 'package:flutter_widget_binder/pages/multiple_states_example/multiple_states_page.dart';
import 'package:flutter_widget_binder/pages/basic_state_example/ui_state_binding_page.dart';
import 'package:flutter_widget_binder/pages/undoable_state_example/undoable_state_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        '/basic': (context) => BasicStatePage(),
        '/ui-binding': (context) => UIStateBindingPage(),
        '/async': (context) => AsyncStatePage(),
        '/dummy-page-a': (context) => const DummyPageA(),
        '/dummy-page-b': (context) => const DummyPageB(),
        '/multiple-states': (context) => const MultipleStatesPage(),
        '/deboucing-state': (context) => const DeboucingStatePage(),
        '/undoable-state': (context) => const UndoableStatePage(),
      },
    );
  }
}
