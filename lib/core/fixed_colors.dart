import 'package:flutter/material.dart';

// 테마 전환에도 변경되지 않는 색 정의
@immutable
class FixedColors extends ThemeExtension<FixedColors> {
  const FixedColors({required this.brandColor});
  final Color? brandColor;

  static const FixedColors constant = FixedColors(
    brandColor: Color.fromARGB(255, 56, 151, 253),
  );
  @override
  FixedColors copyWith({Color? brandColor}) =>
      FixedColors(brandColor: brandColor ?? this.brandColor);

  @override
  FixedColors lerp(ThemeExtension<FixedColors>? other, double t) {
    if (other is! FixedColors) return this;
    return FixedColors(brandColor: Color.lerp(brandColor, other.brandColor, t));
  }
}
