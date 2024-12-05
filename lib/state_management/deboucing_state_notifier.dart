part of 'flutter_simple_state_manager.dart';

///
/// Ngô Tài Cơ - 05/12/2024
///
/// `DebounceStateNotifier`
///
/// Đây là một lớp dùng để quản lý trạng thái (state) có tính năng **debounce**.
///
/// Mục đích:
/// - Giúp kiểm soát tần suất cập nhật state, tránh việc thông báo (notify) quá nhiều lần trong thời gian ngắn.
/// - Hữu ích trong các trường hợp như xử lý sự kiện nhập liệu, tìm kiếm, hoặc các thao tác đòi hỏi giảm thiểu số lần cập nhật.
///
/// Đặc điểm:
/// - Chỉ phát tín hiệu cập nhật (notify) khi giá trị không thay đổi trong một khoảng thời gian nhất định (debounce duration).
/// - Hỗ trợ thiết lập khoảng thời gian debounce thông qua tham số `debounceDuration`.
///
/// `T` là kiểu dữ liệu tổng quát (generic), đại diện cho kiểu của state mà notifier quản lý.
///
/// Các thành phần:
/// - `_value`: Biến private lưu giữ giá trị hiện tại của state.
/// - `_controller`: Một StreamController dùng để phát tín hiệu (notify) đến các listeners khi state thay đổi.
/// - `_debounceTimer`: Một Timer để thực hiện cơ chế debounce.
///
/// Các phương thức:
/// - `update`: Cập nhật giá trị mới cho state sau khoảng thời gian debounce (mặc định là 300ms).
/// - `dispose`: Hủy bỏ timer và giải phóng tài nguyên khi state notifier không còn cần thiết.
///
/// Các lưu ý:
/// - Timer sẽ được reset mỗi khi gọi `update`, do đó giá trị mới sẽ chỉ được notify sau khi hết khoảng thời gian debounce.
/// - Luôn gọi `dispose` để đảm bảo tài nguyên được giải phóng.
///
class DebounceStateNotifier<T> implements BaseStateNotifier<T> {
  /// [_value] là 1 biến private với type là T dựa trên đầu vào mong muốn của người dùng
  ///
  /// [_controller] là 1 biến stream phục vụ cho việc lắng nghe sự thay đổi trong toàn app
  T _value;
  final StreamController<T> _controller = StreamController.broadcast();

  /// Biến Timer dùng để thực hiện cơ chế debounce.
  Timer? _debounceTimer;

  /// Đây là contructor của [DebounceStateNotifier]
  ///
  /// Đầu vào sẽ là 1 object bất kỳ
  DebounceStateNotifier(this._value);

  @override
  T get value => _value;

  @override
  Stream<T> get stream => _controller.stream;

  /// Cập nhật giá trị mới cho state với cơ chế debounce.
  /// - [newValue]: Giá trị mới cần cập nhật.
  /// - [debounceDuration]: Thời gian debounce (mặc định là 300ms).
  ///
  /// Sau khi khoảng thời gian debounce trôi qua, giá trị mới sẽ được gán vào `_value`
  /// và phát tín hiệu (notify) đến các listeners qua `_controller`.
  void update(T newValue,
      {Duration debounceDuration = const Duration(milliseconds: 300)}) {
    _debounceTimer?.cancel(); // Hủy Timer trước đó nếu tồn tại.
    _debounceTimer = Timer(debounceDuration, () {
      _value = newValue;
      _controller.add(_value); // Notify giá trị mới đến các listeners.
    });
  }

  /// Phương thức `dispose`:
  ///
  /// Hủy Timer đang hoạt động (nếu có) và đóng StreamController để giải phóng tài nguyên.
  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.close();
  }
}
