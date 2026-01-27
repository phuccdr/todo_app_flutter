import 'dart:ui';

extension HexColor on String {
  Color toColor() {
    final hex = replaceAll('#', '');
    final value = hex.length == 6 ? 'FF$hex' : hex;
    return Color(int.parse(value, radix: 16));
  }
}
