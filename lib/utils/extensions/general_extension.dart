import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get mqh => MediaQuery.sizeOf(this).height;
  double get mqw => MediaQuery.sizeOf(this).width;
}

extension EmptySpace on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
