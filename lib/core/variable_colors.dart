import 'package:flutter/material.dart';

// 테마 전환 시 변경되는 색 정의
@immutable
class VariableColors extends ThemeExtension<VariableColors> {
  const VariableColors({
    required this.background100,
    required this.background200,
    required this.background300,
    required this.textColor100,
    required this.textColor200,
  });
  final Color? background100;
  final Color? background200;
  final Color? background300;
  final Color? textColor100;
  final Color? textColor200;

  static const VariableColors light = VariableColors(
    background100: Color(0xFFF5F5F5),
    background200: Color(0xFFE0E0E0),
    background300: Color(0xFFBDBDBD),
    textColor100: Color(0xFF686868),
    textColor200: Color(0xFF202020),
  );
  static const VariableColors dark = VariableColors(
    background100: Color(0xFF2E2E2E),
    background200: Color(0xFF1F1F1F),
    background300: Color(0xFF121212),
    textColor100: Color(0xFFD4D4D4),
    textColor200: Color(0xFFFFFFFF),
  );

  @override
  VariableColors copyWith({
    Color? background100,
    Color? background200,
    Color? background300,
  }) => VariableColors(
    background100: background100 ?? this.background100,
    background200: background200 ?? this.background200,
    background300: background300 ?? this.background300,
    textColor100: textColor100 ?? this.textColor100,
    textColor200: textColor200 ?? this.textColor200,
  );

  @override
  VariableColors lerp(ThemeExtension<VariableColors>? other, double t) {
    if (other is! VariableColors) return this;
    return VariableColors(
      background100: Color.lerp(background100, other.background100, t),
      background200: Color.lerp(background200, other.background200, t),
      background300: Color.lerp(background300, other.background300, t),
      textColor100: Color.lerp(textColor100, other.textColor100, t),
      textColor200: Color.lerp(textColor200, other.textColor200, t),
    );
  }
}
