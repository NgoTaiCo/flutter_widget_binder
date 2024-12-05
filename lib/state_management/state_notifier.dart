part of 'flutter_simple_state_manager.dart';

///
/// `StateNotifier`
///
/// Đây là một lớp dùng để quản lý trạng thái (state) trong ứng dụng Flutter.
///
/// Mục đích:
/// - Cung cấp cơ chế đơn giản để quản lý state.
/// - Cho phép phát tín hiệu (notify) khi state thay đổi, giúp các thành phần trong ứng dụng có thể lắng nghe và cập nhật tương ứng.
///
/// Đặc điểm:
/// - Sử dụng generic `T` để đại diện cho kiểu dữ liệu của state.
/// - Kế thừa interface `BaseStateNotifier<T>`, triển khai các thuộc tính và phương thức cần thiết.
/// - Sử dụng `StreamController` để phát tín hiệu (stream) mỗi khi state thay đổi.
///
/// Các thành phần:
/// - `_value`: Biến private lưu trữ giá trị hiện tại của state.
/// - `_controller`: Một `StreamController` để phát tín hiệu mỗi khi state thay đổi.
///
/// Các phương thức:
/// - `setValue`: Cập nhật giá trị mới cho state và notify nếu giá trị thay đổi.
/// - `dispose`: Giải phóng tài nguyên bằng cách đóng `StreamController`.
///
/// `T` là kiểu dữ liệu tổng quát (generic), cho phép class hoạt động với bất kỳ kiểu dữ liệu nào.
///
/// Lưu ý:
/// - Hàm `setValue` sẽ chỉ notify nếu giá trị mới khác với giá trị hiện tại.
/// - Luôn gọi `dispose` để tránh rò rỉ tài nguyên.
/// - Sử dụng class này cho các trường hợp quản lý state đơn giản.
///
/// Class này có thể được sử dụng cho nhiều loại state khác nhau nhờ generic `T`.
///
class StateNotifier<T> implements BaseStateNotifier<T> {
  /// [_value] là 1 biến private với type là T dựa trên đầu vào mong muốn của người dùng
  ///
  /// [_controller] là 1 biến stream phục vụ cho việc lắng nghe sự thay đổi trong toàn app
  T _value;
  final StreamController<T> _controller = StreamController.broadcast();

  /// Đây là contructor của [StateNotifier]
  ///
  /// Đầu vào sẽ là 1 object bất kỳ
  StateNotifier(this._value);

  /// Thuộc tính getter trả về giá trị hiện tại của state.
  @override
  T get value => _value;

  /// Thuộc tính getter cung cấp stream phát tín hiệu mỗi khi state thay đổi.
  @override
  Stream<T> get stream => _controller.stream;

  /// Phương thức `setValue`:
  ///
  /// Cập nhật giá trị mới cho state.
  /// - [newValue]: Giá trị mới cần cập nhật.
  ///
  /// Nếu giá trị mới khác với giá trị hiện tại, state sẽ được cập nhật và notify qua `StreamController`.
  void setValue(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _controller.add(_value); // Phát tín hiệu với giá trị mới.
    }
  }

  /// Phương thức `dispose`:
  ///
  /// Giải phóng tài nguyên bằng cách đóng `StreamController`.
  @override
  void dispose() => _controller.close();
}
