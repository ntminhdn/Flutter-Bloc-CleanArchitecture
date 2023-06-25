import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

class CommonPagedListView<T> extends StatelessWidget {
  const CommonPagedListView({
    required this.pagingController,
    required this.itemBuilder,
    this.animateTransitions = true,
    this.transitionDuration = DurationConstants.defaultListGridTransitionDuration,
    this.firstPageErrorIndicator,
    this.newPageErrorIndicator,
    this.firstPageProgressIndicator,
    this.newPageProgressIndicator,
    this.noItemsFoundIndicator,
    this.noMoreItemsIndicator,
    super.key,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.cacheExtent,
    this.restorationId,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.separatorBuilder,
    this.itemSize,
    this.snapping = false,
    this.selectedAnchorItem = SelectedAnchorItem.middle,
  });

  final CommonPagingController<T> pagingController;
  final Widget Function(
    BuildContext context,
    T item,
    int index,
  ) itemBuilder;
  final bool animateTransitions;
  final Duration transitionDuration;
  final Widget? firstPageErrorIndicator;
  final Widget? newPageErrorIndicator;
  final Widget? firstPageProgressIndicator;
  final Widget? newPageProgressIndicator;
  final Widget? noItemsFoundIndicator;
  final Widget? noMoreItemsIndicator;

  final ScrollController? scrollController;
  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? itemExtent;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final IndexedWidgetBuilder? separatorBuilder;

  ///Composed of the size of each item + its margin/padding.
  ///
  ///Size used is width if `scrollDirection` is `Axis.horizontal`, height if `Axis.vertical`.
  ///
  ///Example:
  ///- Horizontal list
  ///- Card with `width` 100
  ///- Margin is `EdgeInsets.symmetric(horizontal: 5)`
  ///- itemSize is `100+5+5 = 110`
  final double? itemSize;

  ///Anchor location for anchor item in the list
  final SelectedAnchorItem selectedAnchorItem;

  /// Allows snaping event to an item
  final bool snapping;

  @override
  Widget build(BuildContext context) {
    final builderDelegate = PagedChildBuilderDelegate<T>(
      itemBuilder: itemBuilder,
      animateTransitions: animateTransitions,
      transitionDuration: transitionDuration,
      firstPageErrorIndicatorBuilder: (_) =>
          firstPageErrorIndicator ?? const CommonFirstPageErrorIndicator(),
      newPageErrorIndicatorBuilder: (_) =>
          newPageErrorIndicator ?? const CommonNewPageErrorIndicator(),
      firstPageProgressIndicatorBuilder: (_) =>
          firstPageProgressIndicator ?? const CommonFirstPageProgressIndicator(),
      newPageProgressIndicatorBuilder: (_) =>
          newPageProgressIndicator ?? const CommonNewPageProgressIndicator(),
      noItemsFoundIndicatorBuilder: (_) =>
          noItemsFoundIndicator ?? const CommonNoItemsFoundIndicator(),
      noMoreItemsIndicatorBuilder: (_) =>
          noMoreItemsIndicator ?? const CommonNoMoreItemsIndicator(),
    );

    PagedListView<int, T> pagedView(double maxWidth, double maxHeight) => separatorBuilder != null
        ? PagedListView.separated(
            pagingController: pagingController.pagingController,
            builderDelegate: builderDelegate,
            separatorBuilder: separatorBuilder!,
            scrollDirection: scrollDirection,
            reverse: reverse,
            scrollController: scrollController,
            primary: primary,
            physics: snapping
                ? CommonPagingScrollSnapPhysics(
                    itemSize: itemSize!,
                    selectedAnchorItem: selectedAnchorItem,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    isHorizontal: scrollDirection == Axis.horizontal,
                  )
                : physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            cacheExtent: cacheExtent,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
          )
        : PagedListView<int, T>(
            pagingController: pagingController.pagingController,
            builderDelegate: builderDelegate,
            scrollDirection: scrollDirection,
            reverse: reverse,
            scrollController: scrollController,
            primary: primary,
            physics: snapping
                ? CommonPagingScrollSnapPhysics(
                    itemSize: itemSize!,
                    selectedAnchorItem: selectedAnchorItem,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    isHorizontal: scrollDirection == Axis.horizontal,
                  )
                : physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            cacheExtent: cacheExtent,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
          );

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraint) {
        return pagedView(constraint.maxWidth, constraint.maxHeight);
      },
    );
  }
}
