part of 'flutter_simple_state_manager.dart';

///
/// Ngô Tài Cơ - 5/12/24
/// [AsyncStateNotifier] là class dùng để quản lý state bất đồng bộ
///
class AsyncStateNotifier<T> implements BaseStateNotifier<T> {
  /// [_value] là 1 biến private với type là T dựa trên đầu vào mong muốn của người dùng
  ///
  /// [_controller] là 1 biến stream phục vụ cho việc lắng nghe sự thay đổi trong toàn app
  T _value;
  final StreamController<T> _controller = StreamController.broadcast();

  /// Đây là contructor của [AsyncStateNotifier]
  ///
  /// Đầu vào sẽ là 1 object bất kỳ
  AsyncStateNotifier(this._value);

  /// Thuộc tính getter trả về giá trị hiện tại của state.
  @override
  T get value => _value;

  /// Thuộc tính getter cung cấp stream phát tín hiệu mỗi khi state thay đổi.
  @override
  Stream<T> get stream => _controller.stream;

  /// Hàm update này dùng để update giá trị và notify cho các widget đang sử stream để lắng nghe
  ///
  /// đầu vào sẽ là 1 hàm với current chính là state hiện tại [_value]
  ///
  /// Sau khi xử lý với state hiện tại thì sẽ trả về giá trị mới cho [_value]
  ///
  /// và dùng add để notify tới các widget đang lắng nghe
  void update(T Function(T current) updater) {
    _value = updater(_value);
    _controller.add(_value);
  }

  /// Hàm update này dùng để update giá trị và notify cho các widget đang sử stream để lắng nghe
  ///
  /// Nhưng nó sẽ là 1 hàm bất đồng bộ
  ///
  /// Theo quy tắc nó sẽ đợi cho tới khi updater xử lý xong với tiếp tục line tiếp theo
  ///
  /// Sau khi xử lý với state hiện tại thì sẽ trả về giá trị mới cho [_value]
  ///
  /// và dùng add để notify tới các widget đang lắng nghe
  Future<void> updateAsync(Future<T> Function(T current) updater) async {
    _value = await updater(_value);
    _controller.add(_value);
  }

  /// Hàm này đơn giản sẽ reset state lại với giá trí mong muốn
  void reset(T defaultValue) {
    _value = defaultValue;
    _controller.add(_value);
  }

  /// Phương thức `dispose`:
  ///
  /// Giải phóng tài nguyên bằng cách đóng `StreamController`.
  @override
  void dispose() => _controller.close();
}
