import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/ui/post/add_tag_page.dart';
import 'package:lushan/ui/widgets/loading_dialog.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import '../image_bean.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  int moveAction = MotionEvent.actionUp;
  bool _canDelete = false;
  List<ImageBean> imageList = [];
  TextEditingController _textEditingController = TextEditingController();
  List<String> _tags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          '发表动态',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消', style: Theme.of(context).textTheme.subtitle1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: imageList.isNotEmpty ? _createPost : null,
              child: Text(
                '发表',
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '描述:',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        maxLines: 2,
                        decoration: InputDecoration.collapsed(hintText: ""),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    var data = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddTagPage()));
                    if (null != data) {
                      _tags = data;
                      setState(() {});
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '标签:',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Wrap(
                          spacing: 5,
                          children: _tags
                              .map((tag) => InputChip(label: Text(tag)))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              Divider(),
              DragSortView(
                imageList,
                space: 5,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return Image(
                    fit: BoxFit.fill,
                    image: AssetImage(imageList[index].originPath!),
                  );
                },
                initBuilder: (BuildContext context) {
                  if (imageList.length >= 3) {
                    return Container();
                  }
                  return InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      color: Color(0XFFCCCCCC),
                      child: Center(
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  );
                },
                onDragListener: (MotionEvent event, double itemWidth) {
                  switch (event.action) {
                    case MotionEvent.actionDown:
                      moveAction = event.action!;
                      setState(() {});
                      break;
                    case MotionEvent.actionMove:
                      double x = event.globalX! + itemWidth;
                      double y = event.globalY! + itemWidth;
                      double maxY =
                          MediaQuery.of(context).size.height - 1 * 100;
                      print('Sky24n maxY: $maxY, x: $x, y: $y');
                      if (_canDelete && (y < maxY)) {
                        setState(() {
                          _canDelete = false;
                        });
                      } else if (!_canDelete && y > maxY) {
                        setState(() {
                          _canDelete = true;
                        });
                      }
                      break;
                    case MotionEvent.actionUp:
                      moveAction = event.action!;
                      if (_canDelete) {
                        setState(() {
                          _canDelete = false;
                        });
                        return true;
                      } else {
                        setState(() {});
                      }
                      break;
                  }
                  return false;
                },
              ),
            ],
          )),
          if (moveAction != MotionEvent.actionUp)
            Container(
              height: 80,
              color: Colors.red,
              child: Center(
                  child: TextButton(
                onPressed: () {},
                child: _canDelete
                    ? Text(
                        '松手即可删除',
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        '删除',
                        style: TextStyle(color: Colors.white),
                      ),
              )),
            )
        ],
      ),
    );
  }

  void _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickMultiImage();
      if (null != pickedFile) {
        var pickedImageList =
            pickedFile.map((file) => ImageBean(originPath: file.path)).toList();
        imageList.addAll(pickedImageList);
        if (imageList.length > 3) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('最多只能三张图片')));
        }
        while (imageList.length > 3) {
          imageList.removeLast();
        }
        setState(() {});
      }
    } catch (e) {
      print("---->pick image error: ${e.toString()}");
    }
  }

  void _createPost() async {
    late BuildContext dialogContext;
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          dialogContext = context;
          return LoadingDialog();
        });
    var createPostUseCase = UseCaseLocator.createPostUseCase;
    var desc = _textEditingController.text;
    var ret = await createPostUseCase.execute(
        desc, _tags, imageList.map((e) => e.originPath!).toList());
    Navigator.of(context).pop();
    if (ret) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('帖子发送失败!')));
    }
  }
}
