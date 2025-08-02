import 'package:flutter/material.dart';

extension OpacityExtension on Color {
  Color changeOpacity(double opacity) => withValues(alpha: opacity);
}
