import 'dart:async';
import 'dart:ui';

class Debouncer {
  static Timer? _timer;
  static bool _isActive = false;

  static run(VoidCallback action, [int delay = 1000]) {
    if (_isActive) {
      return;
    }

    _isActive = true;
    action();
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delay), () {
      _isActive = false;
    });
  }

  static void dispose() {
    _timer?.cancel();
  }
}
