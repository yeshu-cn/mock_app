import 'package:flutter/material.dart';

typedef LoadMoreCallback = void Function();

class LoadMoreWidget extends StatefulWidget {
  final LoadMoreCallback _loadMoreCallback;

  LoadMoreWidget({
    required LoadMoreCallback loadMoreCallback,
  }) : _loadMoreCallback = loadMoreCallback;

  @override
  _LoadMoreWidgetState createState() => _LoadMoreWidgetState();


}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  @override
  Widget build(BuildContext context) {
    widget._loadMoreCallback.call();
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('加载中...'),
              SizedBox(width: 6,),
              Container(child: CircularProgressIndicator(), width: 20, height: 20,)
            ],
          ),
        ));
  }
}
