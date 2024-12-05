import 'package:flutter_widget_binder/state_management/state_notifier.dart';

///
/// Ngô Tài Cơ - 5/12/24
/// AppState là 1 biến toàn cục có thể truy cập ở bất kỳ đâu
/// Lớp này hoạt động như 1 biến singleton
///
class AppState {
  /// Khai báo biến static
  /// Biến này được định nghĩa là static và final, nghĩa là nó thuộc về class [AppState] và chỉ được khởi tạo một lần duy nhất.
  /// Biến [_instance] sẽ không được tạo ra ngay khi biên dịch ứng dụng, mà chỉ được khởi tạo lần đầu tiên khi [AppState] được truy cập.
  /// Sau khi khởi tạo, biến này sẽ được lưu trữ trong bộ nhớ và được chia sẻ trong toàn bộ ứng dụng
  static final AppState _instance = AppState._internal();

  /// Đây là factory để triển khai mô hình Singleton
  /// Nó đảm bảo việc bất cứ lúc truy cập/khởi tạo nào cũng sẽ quy về [_instance] của AppState
  factory AppState() => _instance;

  /// Đây là 1 biến ví dụ cho AppState
  /// Khởi tạo nó thông qua class [StateNotifier] kèm với type là bool và giá trị khởi tạo là false
  final StateNotifier<bool> sharedCheckerNotifier = StateNotifier<bool>(false);

  /// Đây là private contructor
  AppState._internal();
}
