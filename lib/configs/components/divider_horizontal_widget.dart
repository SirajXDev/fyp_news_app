import 'package:flutter/material.dart';

class DividerHorizontalWidget extends StatelessWidget {
  const DividerHorizontalWidget({
    super.key,
    this.startIndent,
    this.endIndent,
    this.height,
    this.weight,
  });
  final double? startIndent;
  final double? endIndent;
  final double? height;
  final double? weight;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 4,
      indent: startIndent ?? 2,
      endIndent: endIndent ?? 12,
      thickness: weight ?? .16,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
