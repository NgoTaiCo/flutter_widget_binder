part of 'flutter_simple_state_manager.dart';

///
/// `UndoableStateNotifier`
///
/// Ngô Tài Cơ - 05/12/2024
///
/// `UndoableStateNotifier` là một lớp dùng để quản lý trạng thái (state) với khả năng hỗ trợ **undo** và **redo**.
///
/// Mục đích:
/// - Cung cấp tính năng quay lại trạng thái trước đó (undo) hoặc tiến tới trạng thái kế tiếp (redo).
/// - Hữu ích trong các ứng dụng cần chỉnh sửa hoặc thay đổi nhiều bước, ví dụ: trình soạn thảo văn bản, đồ họa, hoặc các hành vi cần kiểm soát lịch sử.
///
/// Đặc điểm:
/// - Quản lý lịch sử các trạng thái trong một danh sách (_history).
/// - Sử dụng chỉ số hiện tại (_currentIndex) để theo dõi trạng thái đang được sử dụng.
/// - Gửi thông báo (notify) mỗi khi trạng thái được thay đổi thông qua Stream.
///
/// `T` là kiểu dữ liệu tổng quát (generic), đại diện cho kiểu của state mà notifier quản lý.
///
/// Các thành phần:
/// - `_history`: Danh sách lưu trữ lịch sử các trạng thái.
/// - `_currentIndex`: Chỉ số của trạng thái hiện tại trong danh sách lịch sử.
/// - `_controller`: Một StreamController dùng để phát tín hiệu (notify) đến các listeners khi state thay đổi.
///
/// Các phương thức:
/// - `update`: Cập nhật trạng thái mới, đồng thời lưu vào danh sách lịch sử và xóa các trạng thái tương lai nếu có.
/// - `undo`: Quay lại trạng thái trước đó, nếu có.
/// - `redo`: Tiến tới trạng thái kế tiếp, nếu có.
/// - `dispose`: Giải phóng tài nguyên khi không còn sử dụng.
///
/// Các lưu ý:
/// - Nếu gọi `undo` tại trạng thái đầu tiên hoặc `redo` tại trạng thái cuối cùng, không có gì xảy ra.
/// - Khi thêm trạng thái mới qua `update`, tất cả các trạng thái "tương lai" (nếu có) sẽ bị xóa.
///
/// Class này là một phần mở rộng của interface `BaseStateNotifier<T>`.
///
class UndoableStateNotifier<T> extends BaseStateNotifier<T> {
  /// Danh sách lưu trữ lịch sử các trạng thái.
  final List<T> _history = [];

  /// Chỉ số của trạng thái hiện tại trong danh sách lịch sử.
  int _currentIndex = -1;

  /// StreamController dùng để phát tín hiệu khi trạng thái thay đổi.
  final StreamController<T> _controller = StreamController.broadcast();

  /// Constructor để khởi tạo trạng thái ban đầu.
  ///
  /// [initialValue] là giá trị mặc định cho trạng thái ban đầu.
  UndoableStateNotifier(T initialValue) {
    _history.add(initialValue);
    _currentIndex++;
    _controller.add(initialValue);
  }

  /// Getter để lấy giá trị trạng thái hiện tại.
  @override
  T get value => _history[_currentIndex];

  /// Getter cung cấp stream phát tín hiệu mỗi khi trạng thái thay đổi.
  @override
  Stream<T> get stream => _controller.stream;

  /// Phương thức `update`:
  ///
  /// Cập nhật trạng thái mới và thêm vào lịch sử.
  /// Nếu đang ở giữa lịch sử (không phải trạng thái cuối cùng), các trạng thái "tương lai" sẽ bị xóa.
  ///
  /// [newValue] là giá trị mới của trạng thái.
  void update(T newValue) {
    if (_currentIndex < _history.length - 1) {
      _history.removeRange(_currentIndex + 1, _history.length);
    }
    _history.add(newValue);
    _currentIndex++;
    _controller.add(newValue);
  }

  /// Phương thức `undo`:
  ///
  /// Quay lại trạng thái trước đó, nếu có.
  void undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _controller.add(value);
    }
  }

  /// Phương thức `redo`:
  ///
  /// Tiến tới trạng thái kế tiếp, nếu có.
  void redo() {
    if (_currentIndex < _history.length - 1) {
      _currentIndex++;
      _controller.add(value);
    }
  }

  /// Phương thức `dispose`:
  ///
  /// Giải phóng StreamController để tránh rò rỉ tài nguyên.
  @override
  void dispose() {
    _controller.close();
  }
}
