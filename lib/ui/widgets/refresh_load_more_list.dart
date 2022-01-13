import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lushan/ui/widgets/load_more_widget.dart';

typedef RefreshCallback = Future<void> Function();
typedef HasMoreDataCallback = bool Function();

class RefreshLoadMoreList extends StatefulWidget {
  final SliverChildBuilderDelegate _sliverChildBuilderDelegate;
  final LoadMoreCallback _onLoadMore;
  final RefreshCallback _onRefresh;
  final HasMoreDataCallback _hasMoreData;

  @override
  _RefreshLoadMoreListState createState() => _RefreshLoadMoreListState();

  const RefreshLoadMoreList({
    required SliverChildBuilderDelegate sliverChildBuilderDelegate,
    required LoadMoreCallback loadMoreCallback,
    required RefreshCallback onRefresh,
    required HasMoreDataCallback hasMoreDataCallback,
  })  : _sliverChildBuilderDelegate = sliverChildBuilderDelegate,
        _onLoadMore = loadMoreCallback,
        _onRefresh = onRefresh,
        _hasMoreData = hasMoreDataCallback;
}

class _RefreshLoadMoreListState extends State<RefreshLoadMoreList> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: widget._onRefresh,
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          if (index < widget._sliverChildBuilderDelegate.childCount!) {
            return widget._sliverChildBuilderDelegate.builder(context, index);
          } else {
            if (widget._hasMoreData.call()) {
              return LoadMoreWidget(loadMoreCallback: widget._onLoadMore);
            }
          }
        }, childCount: widget._sliverChildBuilderDelegate.childCount! + 1))
      ],
    );
  }
}
