/// *****
/// Link description and example:
/// https://bitbucket.org/nal-solutions/nmtb-nals-mobile-team-brain/pull-requests/13
/// *****
import 'dart:math';

import 'package:flutter/material.dart';

enum SelectedAnchorItem { start, middle, end }

class CommonPagingScrollSnapPhysics extends ScrollPhysics {
  const CommonPagingScrollSnapPhysics({
    required this.itemSize,
    required this.selectedAnchorItem,
    required this.maxWidth,
    required this.maxHeight,
    required this.isHorizontal,
    super.parent,
  });

  final double itemSize;
  final SelectedAnchorItem selectedAnchorItem;
  final double maxWidth;
  final double maxHeight;
  final bool isHorizontal;

  @override
  bool get allowImplicitScrolling => false;

  @override
  CommonPagingScrollSnapPhysics applyTo(ScrollPhysics? ancestor) {
    return CommonPagingScrollSnapPhysics(
      itemSize: itemSize,
      selectedAnchorItem: selectedAnchorItem,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      isHorizontal: isHorizontal,
      parent: buildParent(ancestor),
    );
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = toleranceFor(FixedScrollMetrics(
      minScrollExtent: null,
      maxScrollExtent: null,
      pixels: null,
      viewportDimension: null,
      axisDirection: AxisDirection.down,
      devicePixelRatio: WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio,
    ));
    final double target = _getTargetPixels(position, tolerance, velocity);

    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }

    return null;
  }

  /// Caltulator padding item anchor
  /// maxWidth or maxHeight depending on axis
  /// maxWidth if axis is horizontal
  /// maxHeight if axis is vertical
  double _getPadding() {
    double _padding = 0;
    switch (selectedAnchorItem) {
      case SelectedAnchorItem.start:
        _padding = 0;
        break;
      case SelectedAnchorItem.middle:
        _padding = ((isHorizontal ? maxWidth : maxHeight) - itemSize) / 2;
        break;
      case SelectedAnchorItem.end:
        _padding = (isHorizontal ? maxWidth : maxHeight) - itemSize;
        break;
    }

    return _padding;
  }

  /// Get pixels to scroll to target position
  /// If SelectedItemAnchor is middle
  ///
  /// `pixels  = page * itemSize`
  ///
  /// But we want that item to always be in the middle then we should calculate padding by function _getPadding()
  ///
  /// Example:
  ///
  /// `itemSize = 110`, `page =  2` (use function _getPage())
  ///
  /// `page * itemSize - max(0, _getPadding()),`
  ///
  /// `( 2 * 110 ) -  132.5 = 87.5` =>>> pixels anchor is `87.5`
  double _getPixels(ScrollMetrics position, double page) {
    return min(
      max(
        page * itemSize - max(0, _getPadding()),
        position.minScrollExtent,
      ),
      position.maxScrollExtent,
    );
  }

  /// Caltulator target pixels
  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }

    return _getPixels(position, page.roundToDouble());
  }

  /// calculate page number of list
  double _getPage(ScrollMetrics position) {
    return (position.pixels + _getPadding()) / itemSize;
  }
}
