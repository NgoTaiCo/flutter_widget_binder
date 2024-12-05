# Flutter Widget Binder

`flutter_widget_binder` is a Flutter package designed for managing application states efficiently. The package provides various state management solutions, including simple state notifiers, asynchronous state notifiers, debounce functionality, undo/redo capabilities, and multiple state grouping. These tools help manage the state of your application in a modular and scalable way.

## Features
- **State Notifiers**: Simple state management that allows you to track and update states.
- **Async State Notifiers**: Manage asynchronous states and notify listeners on changes.
- **Debouncing State Notifier**: A state notifier that debounces state changes, useful for managing user inputs like search fields.
- **Undoable State Notifier**: Supports undo and redo operations, ideal for applications that require state history tracking.
- **Multiple State Notifiers**: Combines multiple state notifiers into one, emitting a combined stream.

## Installation

Add the following dependency to your `pubspec.yaml` file:

Then, run the following command to install the package:
```flutter pub get```

Usage
AppState Singleton
The `AppState` class provides a global, singleton instance for managing shared application state.
```dart
class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() => _instance;

  final StateNotifier<bool> sharedCheckerNotifier = StateNotifier<bool>(false);

  AppState._internal();
}
```

### StateNotifier
`StateNotifier` is a basic state manager that allows state updates and listeners.
```dart
StateNotifier<int> counter = StateNotifier<int>(0);

counter.stream.listen((value) {
  print(value); // Prints state updates
});

counter.setValue(1); // Updates the state to 1
```

### AsyncStateNotifier
`AsyncStateNotifier` allows handling asynchronous state updates, such as fetching data from an API.
```dart
AsyncStateNotifier<String> asyncStateNotifier = AsyncStateNotifier<String>("Initial Data");

asyncStateNotifier.updateAsync((currentState) async {
  await Future.delayed(Duration(seconds: 2));
  return "Updated Data";
});
```

### DebounceStateNotifier
`DebounceStateNotifier` helps in managing state changes with debouncing functionality.
```dart
DebounceStateNotifier<String> searchQuery = DebounceStateNotifier<String>("");

searchQuery.update("new query", debounceDuration: Duration(milliseconds: 500));

```

### UndoableStateNotifier
`UndoableStateNotifier` provides a mechanism to go back and forth in the state history, supporting undo and redo operations.
```dart
UndoableStateNotifier<int> undoableCounter = UndoableStateNotifier<int>(0);

undoableCounter.update(1); // Adds 1 to history
undoableCounter.update(2); // Adds 2 to history

undoableCounter.undo(); // Reverts back to 1
undoableCounter.redo(); // Moves forward to 2

```

### MultipleStatesNotifier
`MultipleStatesNotifier` combines multiple state notifiers into a single stream, emitting a combined value when any of the states change.
```dart
StateNotifier<int> counter1 = StateNotifier<int>(0);
StateNotifier<String> counter2 = StateNotifier<String>("A");

MultipleStatesNotifier<dynamic> combinedState = MultipleStatesNotifier([counter1, counter2]);

combinedState.stream.listen((values) {
  print(values); // Prints the updated list of all states
});

```

## API
**BaseStateNotifier<T>**
This is an abstract class defining the common interface for state management classes:

- **`value`:** Returns the current state value.
- **`stream`:** A stream that emits the state when it changes.
- **`dispose()`:** Cleans up resources when the state notifier is no longer needed.

**StateNotifier<T>**
A simple state notifier class:

- **`setValue(T newValue)`:** Updates the state and notifies listeners.
- **`dispose()`:** Releases resources by closing the stream.

**AsyncStateNotifier<T>**
An async version of the state notifier that handles asynchronous operations:

- **`updateAsync(Future<T> Function(T current))`:** Updates the state asynchronously and notifies listeners.
- **`dispose()`:** Releases resources by closing the stream.

**DebounceStateNotifier<T>**
A state notifier with debounce functionality:

- **`update(T newValue, {Duration debounceDuration})`:** Updates the state after a debounce period.
- **`dispose()`:** Releases resources by closing the stream.

**UndoableStateNotifier<T>**
A state notifier with undo and redo functionality:

- **`update(T newValue)`:** Updates the state and stores it in history.
- **`undo()`:** Reverts the state to the previous value.
- **`redo()`:** Moves the state forward to the next value.
- **`dispose()`:** Releases resources by closing the stream.

**MultipleStatesNotifier<T>**
A state notifier that manages multiple state notifiers:

- **`values`:** Returns a list of the current values of all managed state notifiers.
- **`stream`:** A stream that emits a list of values when any of the states change.
- **`dispose()`:** Releases resources by closing the stream.

## Widget Binder - Flutter State Management

`WidgetBinder` is a widget designed to connect and manage state with child widgets in a Flutter application. It ensures that child widgets are rebuilt when the state changes, without the need to rebuild the entire widget tree.

### Purpose:
- Ensure that child widgets are always updated with the latest state from a `BaseStateNotifier`.
- Provide an efficient and straightforward way to listen for state changes and update the UI accordingly.

### How It Works:
`WidgetBinder` works by using a `StreamBuilder` to listen to the stream of changes from a `BaseStateNotifier<T>`. Whenever the state changes, the builder function is called to rebuild the widget with the new state.

#### Key Components:
- **`state`**: An object that extends `BaseStateNotifier<T>`, responsible for managing the state and emitting changes.
- **`builder`**: A function that takes the `BuildContext` and the current state value (`T`), and returns a widget. This function is invoked every time the state changes.

### Example
```dart
final counterNotifier = StateNotifier<int>(0);

Widget build(BuildContext context) {
  return WidgetBinder<int>(
    state: counterNotifier,
    builder: (context, value) {
      return Text('Current value: $value');
    },
  );
}
```

If you have any question, please contact me via https://www.facebook.com/KrizSasvozsky
