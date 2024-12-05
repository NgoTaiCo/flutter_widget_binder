import 'dart:async';

import 'package:flutter_widget_binder/state_management/base_notifier.dart';

///
/// Ngô Tài Cơ - 05/12/2024
///
/// `MultipleStatesNotifier`
///
/// Đây là một lớp dùng để quản lý và kết hợp nhiều state notifier thành một nhóm.
///
/// Mục đích:
/// - Lắng nghe sự thay đổi của nhiều state notifier và cung cấp một **stream** duy nhất phát ra danh sách các giá trị hiện tại của tất cả các state.
/// - Hữu ích trong các trường hợp cần đồng bộ hóa nhiều state hoặc cập nhật giao diện dựa trên nhiều nguồn dữ liệu.
///
/// Đặc điểm:
/// - Tự động lắng nghe (listen) tất cả các state notifier được cung cấp.
/// - Phát tín hiệu (notify) mỗi khi có bất kỳ state nào trong nhóm thay đổi.
/// - Duy trì danh sách các giá trị hiện tại của tất cả state thông qua `_currentValues`.
///
/// Các thành phần:
/// - `_states`: Danh sách các `BaseStateNotifier` cần quản lý.
/// - `_combinedController`: Một `StreamController` phát ra danh sách giá trị của tất cả các state.
/// - `_currentValues`: Một danh sách lưu trữ giá trị hiện tại của tất cả các state.
///
/// Các phương thức:
/// - `values`: Trả về danh sách giá trị hiện tại của các state.
/// - `stream`: Trả về một stream phát ra danh sách giá trị mỗi khi có bất kỳ state nào thay đổi.
/// - `dispose`: Đóng `StreamController` và giải phóng tài nguyên của tất cả state notifier trong nhóm.
///
/// Constructor:
/// - Nhận vào danh sách các state notifier (`_states`) cần quản lý.
/// - Tự động thiết lập listener cho từng state notifier và cập nhật danh sách giá trị (`_currentValues`) mỗi khi state thay đổi.
///
/// Các lưu ý:
/// - `dispose()` phải được gọi để giải phóng tài nguyên nhằm tránh rò rỉ bộ nhớ.
/// - Danh sách `_states` phải chứa các `BaseStateNotifier` đã được khởi tạo.
/// - Mỗi state notifier trong nhóm cần đảm bảo tương thích với giao diện `BaseStateNotifier<T>`.
///
class MultipleStatesNotifier<T> extends BaseStateNotifier<List<T>> {
  /// Danh sách các state notifier cần quản lý.
  final List<BaseStateNotifier> _states;

  /// StreamController phát ra danh sách giá trị của các state.
  final StreamController<List<T>> _combinedController = StreamController.broadcast();

  /// Danh sách lưu trữ giá trị hiện tại của tất cả các state.
  late List<T> _currentValues;

  /// Constructor để khởi tạo và thiết lập listener cho tất cả các state notifier trong `_states`.
  ///
  /// - `_states`: Danh sách các `BaseStateNotifier` cần lắng nghe.
  MultipleStatesNotifier(this._states) {
    // Lấy giá trị ban đầu từ tất cả các state.
    _currentValues = _states.map((state) => state.value).toList().cast<T>();

    // Thiết lập listener cho từng state.
    for (int i = 0; i < _states.length; i++) {
      _states[i].stream.listen((newValue) {
        _currentValues[i] = newValue; // Cập nhật giá trị mới.
        _combinedController.add(_currentValues); // Notify danh sách giá trị hiện tại.
      });
    }
  }

  /// Trả về danh sách giá trị hiện tại của tất cả các state.
  @override
  List<T> get value => _currentValues;

  /// Stream phát ra danh sách giá trị mỗi khi có state thay đổi.
  @override
  Stream<List<T>> get stream => _combinedController.stream;

  /// Giải phóng tài nguyên, bao gồm đóng `StreamController` và tất cả state notifier trong nhóm.
  /// @override
  void dispose() {
    _combinedController.close();
    for (var state in _states) {
      state.dispose();
    }
  }
}
