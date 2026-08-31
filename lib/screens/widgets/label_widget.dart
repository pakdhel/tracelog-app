import 'package:flutter/material.dart';
import 'package:tracelog_app/style/colors/tracelog_colors.dart';
import 'package:tracelog_app/style/colors/tracelog_dark_colors.dart';

class LabelWidget extends StatelessWidget {
  final bool isAutoTracked;
  const LabelWidget({super.key, required this.isAutoTracked});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark
        ? (isAutoTracked
              ? TracelogDarkColors.autoTrackedText.color
              : TracelogDarkColors.manualText.color)
        : (isAutoTracked
              ? TracelogColors.autoTrackedText.color
              : TracelogColors.manualText.color);

    final backgroundColor = isDark
        ? (isAutoTracked
              ? TracelogDarkColors.autoTrackedContainer.color
              : TracelogDarkColors.manualContainer.color)
        : (isAutoTracked
              ? TracelogColors.autoTrackedContainer.color
              : TracelogColors.manualContainer.color);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        isAutoTracked ? 'Auto-tracked' : 'Manual',
        style: textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
