import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final bool isAutoTracked;
  const LabelWidget({super.key, required this.isAutoTracked});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = isAutoTracked
        ? colorScheme.onSecondaryContainer
        : colorScheme.onTertiaryContainer;

    final backgroundColor = isAutoTracked
        ? colorScheme.secondaryContainer
        : colorScheme.tertiaryContainer;

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
