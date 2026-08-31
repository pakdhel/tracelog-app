import 'package:flutter/material.dart';

enum TracelogDarkColors {
  primary("primary", Color(0xFFE2E8F0)),
  onPrimary("on primary", Color(0xFF020618)),
  onSurface("on surface", Color(0xFFF8FAFC)),
  surfaceContainer("surface container", Color(0xFF0F172B)),
  onSurfaceVariant("on surface container", Color(0xFF62748E)),
  outline("border", Color(0xFF272E40)),
  background("background", Color(0xFF020617)),

  autoTrackedText("auto tracked text", Color(0xFFC0F3D0)),
  autoTrackedContainer("auto tracked container", Color(0xFF095C34)),
  manualText("manual text", Color(0xFFFDE4BB)),
  manualContainer("manual container", Color(0xFF7D460B));

  const TracelogDarkColors(this.name, this.color);
  final String name;
  final Color color;
}