import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/usecase/dto/post_dto.dart';
import 'package:lushan/ui/widgets/item_post_widget.dart';

class LikePostPage extends StatefulWidget {
  const LikePostPage({Key? key}) : super(key: key);

  @override
  _LikePostPageState createState() => _LikePostPageState();
}

class _LikePostPageState extends State<LikePostPage> {
  List<PostDTO> _posts = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    _posts = await UseCaseLocator.getLikedPostUseCase.execute(0, 1000);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('喜欢'),
      ),
      body: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              // 这里执行完毕后，就会隐藏进度框
              _posts = await UseCaseLocator.getLikedPostUseCase.execute(0, 1000);
              setState(() {});
            },
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return ItemPostWidget(_posts[index]);
          }, childCount: _posts.length))
        ],
      ),
    );
  }
}
