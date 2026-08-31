import 'package:flutter/material.dart';

enum TracelogColors {
  primary("primary", Color(0xFF0F172B)),
  onPrimary("on primary", Color(0xFFF8FAFC)),
  onSurface("on surface", Color(0xFF020618)),
  surfaceContainer("surface container", Color(0xFFF1F5F9)),
  onSurfaceVariant("on surface variant", Color(0xFF62748E)),
  outline("border", Color(0xFFE2E8F0)),
  background("background", Color(0xFFFFFFFF)),

  onSecondaryContainer("auto tracked text", Color(0xFF095C34)),
  onTertiaryContainer("manual text", Color(0xFF7D460B)),
  secondaryContainer("auto tracked container", Color(0xFFC0F3D0)),
  tertiaryContainer("manual container", Color(0xFFFDE4BB));

  const TracelogColors(this.name, this.color);
  final String name;
  final Color color;
}
