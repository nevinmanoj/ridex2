import 'package:flutter/rendering.dart';

List generateDistinctColors(int numColors) {
  List distinctColors = [];
  for (int i = 0; i < numColors; i++) {
    double hue = i / numColors;
    Color color = HSVColor.fromAHSV(1.0, hue * 360, 0.7, 0.9).toColor();
    distinctColors.add(color);
  }
  return distinctColors;
}
