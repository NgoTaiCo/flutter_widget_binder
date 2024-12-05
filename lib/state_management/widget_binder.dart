part of 'flutter_simple_state_manager.dart';

///
/// Ngô Tài Cơ - 05/12/2024
///
/// `WidgetBinder`
///
/// `WidgetBinder` là một widget giúp kết nối và quản lý trạng thái (state) với các widget con trong ứng dụng Flutter.
/// Nó cho phép các widget con tái xây dựng (rebuild) khi trạng thái thay đổi mà không cần phải tái tạo lại toàn bộ tree.
///
/// Mục đích:
/// - Đảm bảo rằng các widget con luôn được cập nhật với giá trị trạng thái mới nhất từ một `BaseStateNotifier`.
/// - Cung cấp một cách tiếp cận đơn giản và hiệu quả để lắng nghe sự thay đổi của state và cập nhật giao diện người dùng.
///
/// `T` là kiểu dữ liệu tổng quát (generic), đại diện cho kiểu của state mà `WidgetBinder` quản lý.
///
/// Các thành phần:
/// - `state`: Một đối tượng kế thừa từ `BaseStateNotifier<T>`, dùng để quản lý và phát tín hiệu về sự thay đổi của state.
/// - `builder`: Một hàm nhận vào `BuildContext` và giá trị của state (`T`), và trả về một widget. Hàm này được gọi mỗi khi giá trị của state thay đổi.
///
/// Cách sử dụng:
/// ```dart
/// final counterNotifier = StateNotifier<int>(0);
///
/// Widget build(BuildContext context) {
///   return WidgetBinder<int>(
///     state: counterNotifier,
///     builder: (context, value) {
///       return Text('Current value: $value');
///     },
///   );
/// }
/// ```
///
/// Cách thức hoạt động:
/// - `WidgetBinder` sử dụng `StreamBuilder` để lắng nghe sự thay đổi của stream từ `state.stream`.
/// - Mỗi khi `state.stream` phát ra giá trị mới, `builder` được gọi lại để xây dựng lại widget con với giá trị mới.
/// - `initialData` được thiết lập là giá trị hiện tại của `state` để đảm bảo rằng widget luôn có dữ liệu ban đầu khi lần đầu tiên được xây dựng.
///
/// Lưu ý:
/// - `WidgetBinder` không tự quản lý việc thay đổi trạng thái. Việc thay đổi state phải được thực hiện từ bên ngoài, thông qua các phương thức của `BaseStateNotifier`.
/// - Đảm bảo rằng `state` luôn được cung cấp một đối tượng kế thừa từ `BaseStateNotifier<T>` để đảm bảo hoạt động đúng.
///
/// `WidgetBinder` giúp tách biệt việc quản lý state và UI, từ đó giúp mã nguồn trở nên dễ duy trì hơn.
///
class WidgetBinder<T> extends StatelessWidget {
  /// Đối tượng state notifier dùng để quản lý trạng thái.
  /// `state` phải là một đối tượng kế thừa từ `BaseStateNotifier<T>`.
  final BaseStateNotifier<T> state;

  /// Hàm builder nhận vào `BuildContext` và giá trị trạng thái `T`, và trả về một widget.
  final Widget Function(BuildContext context, T value) builder;

  /// Constructor của `WidgetBinder`.
  const WidgetBinder({
    super.key,
    required this.state,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: state.stream,
      initialData: state.value,
      builder: (context, snapshot) {
        final value = (snapshot.data as T)!;
        return builder(context, value);
      },
    );
  }
}
