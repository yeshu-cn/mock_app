import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/model/user_profile.dart';
import 'package:lushan/domain/usecase/dto/comment_dto.dart';
import 'package:lushan/domain/usecase/dto/post_dto.dart';
import 'package:lushan/ui/widgets/item_post_widget.dart';
import 'package:lushan/ui/widgets/loading_dialog.dart';
import 'package:lushan/utils/app_constant.dart';
import 'package:lushan/utils/config_utils.dart';
import 'package:lushan/utils/time_utils.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;

  PostDetailPage(this.postId);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  PostDTO? _post;
  List<CommentDTO> _comments = [];
  TextEditingController _textEditingController = TextEditingController();
  CommentDTO? _replyComment;

  UserProfile _userProfile = ConfigUtils.getUserProfile()!;
  @override
  void initState() {
    _loadData();
    _textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _loadData() async {
    _post = await UseCaseLocator.getPostUseCase.execute(widget.postId);
    _comments =
        await UseCaseLocator.getCommentListUseCase.execute(widget.postId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: GestureDetector(
          onTap: () {
            // call this method here to hide soft keyboard
            FocusScope.of(context).requestFocus(new FocusNode());
            _replyComment = null;
            setState(() {});
          },
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (null == _post) {
      return Center(child: Text('no data'));
    } else {
      return Column(
        children: [
          Expanded(
              child: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  _comments = await UseCaseLocator.getCommentListUseCase
                      .execute(widget.postId);
                  setState(() {});
                },
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 0) {
                  return ItemPostWidget(_post!, postDetail: true,);
                } else {
                  return _buildCommentItem(_comments[index - 1]);
                }
              }, childCount: _comments.length + 1))
            ],
          )),
          Container(
            color: Colors.white,
            height: 80,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: TextField(
                      controller: _textEditingController,
                      maxLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _createComment();
                        }
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                          hintStyle: TextStyle(fontSize: 14),
                          hintText: '评论',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: ElevatedButton(
                      onPressed: _textEditingController.text.isEmpty
                          ? null
                          : () {
                              _createComment();
                            },
                      child: Text('发送')),
                )
              ],
            ),
          )
        ],
      );
    }
  }

  String getInputHintText() {
    if (null == _replyComment) {
      return '评论';
    } else {
      return '回复${_replyComment!.replyNickname}';
    }
  }

  void _showDeleteSheet(String commentId) {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text('删除'),
            onPressed: () async {
              Navigator.of(context).pop();
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return LoadingDialog();
                  });
              var ret =
                  await UseCaseLocator.deleteCommentUseCase.execute(commentId);
              Navigator.of(context).pop();
              if (ret) {
                // 更新界面
                _comments.removeWhere((element) => element.id == commentId);
                setState(() {});
              } else {
                // 提示删除失败
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("帖子删除失败"),
                ));
              }
            }),
      ],
      cancelAction: CancelAction(
          title: const Text(
              '取消')), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  Widget _buildCommentItem(CommentDTO comment) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        if (comment.authorUid == _userProfile.id) {
          _showDeleteSheet(comment.id);
        } else {
          _replyComment = comment;
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatarImage(comment.authorAvatar),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            comment.authorNickname,
                            style: textTheme.subtitle1,
                          ),
                        ),
                        Text(
                          TimeUtils.formatTimeString(comment.time),
                          style: textTheme.bodyText2,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                      child: Text(comment.content, style: textTheme.bodyText1),
                    ),
                    Divider()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getComment(CommentDTO comment) {
    if (comment.replyUid == null) {
      return getDirectComment(comment.content);
    } else {
      return getReplyComment(comment.content, comment.replyNickname);
    }
  }

  Widget getDirectComment(String content) {
    return Text(content, style: Theme.of(context).textTheme.bodyText1);
  }

  RichText getReplyComment(String content, String replyNickName) {
    return RichText(
        text: TextSpan(style: Theme.of(context).textTheme.bodyText1, children: [
      TextSpan(text: '回复'),
      TextSpan(
          text: replyNickName, style: Theme.of(context).textTheme.subtitle1),
      TextSpan(text: ':'),
      TextSpan(text: content)
    ]));
  }

  Widget _buildAvatarImage(String avatarUrl) {
    var avatarSize = 38.0;
    if (avatarUrl.isEmpty) {
      return Image(
        fit: BoxFit.fill,
        image: AssetImage(AppConstant.defaultAvatarPath),
        height: avatarSize,
        width: avatarSize,
      );
    } else {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        height: avatarSize,
        width: avatarSize,
        imageUrl: avatarUrl,
      );
    }
  }

  void _createComment() async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return LoadingDialog();
        });
    var createCommentUseCase = UseCaseLocator.createCommentUseCase;
    var replyUid = null == _replyComment ? null : _replyComment!.authorUid;
    var success = await createCommentUseCase.execute(
        widget.postId, _textEditingController.text.trim(),
        replyUid: replyUid);
    Navigator.of(context).pop();
    if (success) {
      _textEditingController.text = '';
      setState(() {});
      // 更新界面
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("评论表送成功"),
      ));
    } else {
      // 提示发表失败
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("评论表送失败"),
      ));
    }
  }
}
