import 'package:flutter/material.dart';

import '../../app.dart';

class CircleShimmer extends StatelessWidget {
  const CircleShimmer({
    this.diameter,
    Key? key,
  }) : super(key: key);

  final double? diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter ?? Dimens.d32.responsive(),
      height: diameter ?? Dimens.d32.responsive(),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
