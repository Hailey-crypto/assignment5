import 'package:flutter/material.dart';
import 'package:assignment4/core/variable_colors.dart';
import 'package:assignment4/core/fixed_colors.dart';

class AppTheme {
  // 라이트 테마 정의
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    extensions: const [VariableColors.light, FixedColors.constant],
  );
  // 다크 테마 정의
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    extensions: const [VariableColors.dark, FixedColors.constant],
  );
}

VariableColors vrc(BuildContext context) =>
    Theme.of(context).extension<VariableColors>()!;

FixedColors fxc(BuildContext context) =>
    Theme.of(context).extension<FixedColors>()!;
