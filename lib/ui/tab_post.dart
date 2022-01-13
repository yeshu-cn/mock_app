import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/usecase/dto/post_dto.dart';
import 'package:lushan/ui/post/add_post_page.dart';
import 'package:lushan/ui/widgets/item_post_widget.dart';
import 'package:lushan/ui/widgets/refresh_load_more_list.dart';
import 'package:lushan/utils/app_constant.dart';

class TabPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabPostState();
  }
}

class _TabPostState extends State<TabPost> {
  List<PostDTO> _posts = [];
  bool hasMoreData = true;

  void _refresh() async {
    _posts = await UseCaseLocator.getPostListUseCase
        .execute(0, AppConstant.pageDataSize);
    hasMoreData = _posts.length >= AppConstant.pageDataSize;
    setState(() {});
  }

  void _loadMore() async {
    var data = await UseCaseLocator.getPostListUseCase
        .execute(_posts.length, AppConstant.pageDataSize);
    hasMoreData = data.length >= AppConstant.pageDataSize;
    _posts.addAll(data);
    setState(() {});
  }

  bool _hasMoreData() {
    return hasMoreData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        leading: Text(''),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddPostPage()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshLoadMoreList(
        loadMoreCallback: _loadMore,
        onRefresh: () async {
          _refresh();
        },
        sliverChildBuilderDelegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return ItemPostWidget(_posts[index]);
        }, childCount: _posts.length),
        hasMoreDataCallback: _hasMoreData,
      ),
    );
  }
}
