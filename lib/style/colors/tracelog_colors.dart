import 'package:flutter/material.dart';

enum TracelogColors {
  primary("primary", Color(0xFF020618)),
  onPrimary("on primary", Color(0xFFF8FAFC)),
  background("background", Color(0xFFFFFFFF)),
  surfaceContainer("background container", Color(0xFFF1F5F9)),
  onSurfaceContainer("on surface container", Color(0xFF62748E)),
  outline("border", Color(0xFFE2E8F0));

  const TracelogColors(this.name, this.color);
  final String name;
  final Color color;
}
