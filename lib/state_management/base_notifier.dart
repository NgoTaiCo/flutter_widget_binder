part of 'flutter_simple_state_manager.dart';

///
/// Ngô Tài Cơ - 05/12/2024
///
/// [BaseStateNotifier]
///
/// Đây là một class trừu tượng (abstract class) đóng vai trò làm **interface**
/// để các lớp quản lý trạng thái (state notifier) khác kế thừa và triển khai.
///
/// Mục đích:
/// - Định nghĩa các phương thức và thuộc tính cơ bản mà một state notifier cần có.
/// - Cung cấp một chuẩn giao tiếp chung giữa state và các thành phần khác trong ứng dụng.
///
/// Đặc điểm:
/// - Cho phép lắng nghe (listen) sự thay đổi của state thông qua [Stream].
/// - Đảm bảo việc quản lý và giải phóng tài nguyên thông qua phương thức [dispose].
///
/// `T` là kiểu dữ liệu tổng quát (generic), đại diện cho kiểu của state mà notifier quản lý.
///
/// Các thành phần:
/// - `value`: Thuộc tính getter, dùng để lấy giá trị hiện tại của state.
/// - `stream`: Thuộc tính getter, cung cấp một stream để phát ra giá trị mỗi khi state thay đổi.
/// - `dispose()`: Phương thức trừu tượng, cần được triển khai để giải phóng tài nguyên.
///
/// Lưu ý:
/// - Khi kế thừa `BaseStateNotifier`, bạn cần đảm bảo tất cả các phương thức được triển khai đầy đủ.
/// - Luôn gọi `dispose()` khi state notifier không còn cần thiết để tránh rò rỉ bộ nhớ.
///
abstract class BaseStateNotifier<T> {
  /// Thuộc tính getter để lấy giá trị hiện tại của state.
  T get value;

  /// Thuộc tính getter cung cấp stream phát ra giá trị mới mỗi khi state thay đổi.
  Stream<T> get stream;

  /// Phương thức trừu tượng, được gọi để giải phóng tài nguyên khi không còn cần thiết.
  void dispose();
}
