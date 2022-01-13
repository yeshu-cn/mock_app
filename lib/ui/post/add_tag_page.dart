import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';

class AddTagPage extends StatefulWidget {
  const AddTagPage({Key? key}) : super(key: key);

  @override
  _AddTagPageState createState() => _AddTagPageState();
}

class _AddTagPageState extends State<AddTagPage> {
  List<String> _tags = [];
  List<String> _selectedTags = [];
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    _loadTags();
    _editingController.addListener(() {setState(() {

    });});
    super.initState();
  }

  void _loadTags() async {
    _tags = await UseCaseLocator.getPostTagListUseCase.execute();
    setState(() {});
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加标签'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedTags);
              },
              child: Text(
                '完成',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 5,
                    children: _selectedTags
                        .map((tag) => InputChip(
                              backgroundColor: Colors.blue,
                              label: Text(tag),
                              onDeleted: () {
                                _deleteTag(tag);
                              },
                            ))
                        .toList(),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Stack(children: [
                        TextField(
                          decoration:
                              new InputDecoration(hintText: '请输入自定义标签，最多10个字符'),
                          maxLength: 10,
                          controller: _editingController,
                        ),
                        if (_editingController.text.length > 0)
                          Positioned(
                              right: 0,
                              child: TextButton(
                                  onPressed: () {
                                    _addCustomTag(_editingController.text);
                                  },
                                  child: Text('添加')))
                      ])),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '热门标签',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Wrap(
                    spacing: 5,
                    children: _tags
                        .map((tag) => InputChip(
                              backgroundColor: _getChipBackgroundColor(tag),
                              label: Text(tag),
                              selected: false,
                              onPressed: () {
                                _onTagPressed(tag);
                              },
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTagPressed(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    setState(() {});
  }

  void _deleteTag(String tag) {
    _selectedTags.remove(tag);
    setState(() {});
  }

  void _addCustomTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _editingController.clear();
      return;
    } else {
      _selectedTags.add(tag);
      _editingController.clear();
      setState(() {});
    }
  }

  Color _getChipBackgroundColor(String tag) {
    if (_selectedTags.contains(tag)) {
      return Colors.blue;
    } else {
      return Colors.grey[400]!;
    }
  }
}
