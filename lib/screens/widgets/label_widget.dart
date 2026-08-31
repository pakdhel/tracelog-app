import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final bool isAutoTracked;
  const LabelWidget({super.key, required this.isAutoTracked});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isAutoTracked ? Color(0xFFC0F3D0) : Color(0xFFFDE4BB),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        isAutoTracked ? 'Auto-tracked' : 'Manual',
        style: textTheme.labelSmall?.copyWith(
          color: isAutoTracked ? Color(0xFF095C34) : Color(0xFF7D460B),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
