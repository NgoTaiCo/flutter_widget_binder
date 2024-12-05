// test/app_state_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_binder/state_management/flutter_simple_state_manager.dart';

void main() {
  test('AppState change to true works correctly', () {
    final appState = AppState().sharedCheckerNotifier;
    appState.setValue(true);
    expect(appState.value, true);
  });

  test('AppState change to false works correctly', () {
    final appState = AppState().sharedCheckerNotifier;
    appState.setValue(false);
    expect(appState.value, false);
  });
}
