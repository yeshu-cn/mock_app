import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lushan/ui/widgets/refresh_load_more_list.dart';

class DemoWidgetPage extends StatefulWidget {
  const DemoWidgetPage({Key? key}) : super(key: key);

  @override
  _DemoWidgetPageState createState() => _DemoWidgetPageState();
}

class _DemoWidgetPageState extends State<DemoWidgetPage> {
  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: RefreshLoadMoreList(
        sliverChildBuilderDelegate:
            SliverChildBuilderDelegate((context, index) {
          return ListTile(title: Text(list[index]),);
        }, childCount: list.length),
        onRefresh: () async {
          _refresh();
        },
        loadMoreCallback: _loadMore, hasMoreDataCallback: hasMoreData,
      ),
    );
  }

  void _refresh() async {
    await Future.delayed(Duration(seconds: 3));
    list = List.generate(10, (index) => index.toString());
    setState(() {

    });
  }

  void _loadMore() async {
    await Future.delayed(Duration(seconds: 3));
    list.addAll(List.generate(10, (index) => (list.length + index).toString()));
    setState(() {

    });
  }

  bool hasMoreData() {
    if (list.length > 30) {
      return false;
    } else {
      return true;
    }
  }
}
