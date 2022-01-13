import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/usecase/dto/post_dto.dart';
import 'package:lushan/ui/post_detail_page.dart';
import 'package:lushan/utils/app_constant.dart';
import 'package:lushan/utils/time_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemPostWidget extends StatefulWidget {
  final PostDTO _post;
  final bool postDetail;

  ItemPostWidget(this._post, {this.postDetail = false});

  @override
  _ItemPostWidgetState createState() => _ItemPostWidgetState();
}

class _ItemPostWidgetState extends State<ItemPostWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildItem(widget._post);
  }

  Widget _buildItem(PostDTO post) {
    PageController pageController = PageController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: _buildAvatarImage(post.avatar),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.nickname,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  TimeUtils.formatTimeString(post.time),
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(post.desc),
        ),
        Container(
          height: 250,
          child: Stack(children: [
            PageView(
              children: _buildImages(post),
              controller: pageController,
            ),
            if (post.images.length > 1)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmoothPageIndicator(
                      controller: pageController,
                      // PageController
                      count: post.images.length,
                      effect: WormEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          dotColor: Colors.white30,
                          activeDotColor:
                              Theme.of(context).colorScheme.primary),
                      // your preferred effect
                      onDotClicked: (index) {
                        pageController.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceOut);
                      }),
                ),
              )
          ]),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  _likePost(widget._post.id, !widget._post.like);
                },
                icon: !widget._post.like
                    ? Icon(Icons.favorite_outline)
                    : Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
            Text(post.likeCount.toString(),
                style: Theme.of(context).textTheme.bodyText2),
            IconButton(
                onPressed: () {
                  if (!widget.postDetail) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PostDetailPage(widget._post.id)));
                  }
                },
                icon: Icon(Icons.chat_bubble_outline)),
            Text(post.commentCount.toString(),
                style: Theme.of(context).textTheme.bodyText2),
            Spacer(),
            IconButton(
                onPressed: () {
                  _favoritePost(widget._post.id, !widget._post.favorite);
                },
                icon: !widget._post.favorite
                    ? Icon(Icons.star_outline)
                    : Icon(
                        Icons.star,
                        color: Colors.red,
                      )),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildImages(PostDTO post) {
    return post.images.map((imageUrl) {
      return Image(
        width: MediaQuery.of(context).size.width,
        image: AssetImage(imageUrl),
        fit: BoxFit.fill,
      );
    }).toList();
  }

  Widget _buildAvatarImage(String avatarUrl) {
    if (avatarUrl.isEmpty) {
      return Image(
        fit: BoxFit.fill,
        image: AssetImage(AppConstant.defaultAvatarPath),
        height: 60,
        width: 60,
      );
    } else {
      return Image(
        fit: BoxFit.fill,
        image: AssetImage(avatarUrl),
        height: 60,
        width: 60,
      );
      // return CachedNetworkImage(
      //   fit: BoxFit.fill,
      //   height: 60,
      //   width: 60,
      //   imageUrl: avatarUrl,
      // );
    }
  }

  void _favoritePost(String postId, bool favorite) async {
    // 预先显示成功的界面
    widget._post.favorite = favorite;
    setState(() {});
    var ret =
        await UseCaseLocator.favoritePostUseCase.execute(postId, favorite);
    if (!ret) {
      // 失败了，恢复收藏状态
      widget._post.favorite = !favorite;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("请求失败"),
      ));
    }
  }

  void _likePost(String postId, bool like) async {
    widget._post.like = like;
    setState(() {});
    var ret = await UseCaseLocator.likePostUseCase.execute(postId, like);
    if (!ret) {
      widget._post.like = !like;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("请求失败"),
      ));
    }
  }
}
