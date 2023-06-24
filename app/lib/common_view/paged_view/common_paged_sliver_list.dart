import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

class CommonPagedSliverList<T> extends StatelessWidget {
  const CommonPagedSliverList({
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
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    this.separatorBuilder,
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

  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? itemExtent;
  final SemanticIndexCallback? semanticIndexCallback;
  final bool shrinkWrapFirstPageIndicators;
  final IndexedWidgetBuilder? separatorBuilder;

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

    final pagedView = separatorBuilder != null
        ? PagedSliverList.separated(
            pagingController: pagingController.pagingController,
            builderDelegate: builderDelegate,
            separatorBuilder: separatorBuilder!,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
            shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
            semanticIndexCallback: semanticIndexCallback,
          )
        : PagedSliverList<int, T>(
            pagingController: pagingController.pagingController,
            builderDelegate: builderDelegate,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
            shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
            semanticIndexCallback: semanticIndexCallback,
          );

    return pagedView;
  }
}
