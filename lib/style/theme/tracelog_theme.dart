import 'package:flutter/material.dart';
import 'package:tracelog_app/style/colors/tracelog_colors.dart';
import 'package:tracelog_app/style/typography/tracelog_textstyles.dart';

class TracelogTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: TracelogColors.primary.color,
        onPrimary: TracelogColors.onPrimary.color,
        outline: TracelogColors.outline.color,
        surfaceContainer: TracelogColors.surfaceContainer.color,
        onSurfaceVariant: TracelogColors.onSurfaceContainer.color,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: TracelogColors.background.color,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headlineMedium: TracelogTextstyles.headlineMedium,
      titleMedium: TracelogTextstyles.titleMedium,
      bodyLarge: TracelogTextstyles.bodyLarge,
      bodyMedium: TracelogTextstyles.bodyMedium,
      bodySmall: TracelogTextstyles.bodySmall,
      labelLarge: TracelogTextstyles.labelLarge,
      labelMedium: TracelogTextstyles.labelMedium,
      labelSmall: TracelogTextstyles.labelSmall,
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: TracelogColors.surfaceContainer.color,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: TracelogColors.outline.color),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: TracelogColors.outline.color),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: TracelogColors.outline.color, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
