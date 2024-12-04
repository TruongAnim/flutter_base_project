import 'dart:math';

mixin NumUtil {
  static int getPercent(int a, int b) {
    return min(((a / b) * 100).toInt(), 100);
  }

  static int roundToMultiple(int number, int floor) {
    return (number / floor).floor() * floor;
  }
}
