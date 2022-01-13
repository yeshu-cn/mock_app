import 'package:flutter/material.dart';
import 'package:lushan/domain/model/post.dart';

class PostListWidget extends StatefulWidget {
  final List<Post> _postList;

  PostListWidget(this._postList);

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
