import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/domain/model/user_profile.dart';
import 'package:lushan/utils/config_utils.dart';

class SetNickNamePage extends StatefulWidget {
  const SetNickNamePage({Key? key}) : super(key: key);

  @override
  _SetNickNamePageState createState() => _SetNickNamePageState();
}

class _SetNickNamePageState extends State<SetNickNamePage> {
  TextEditingController _textEditingController = TextEditingController();
  UserProfile _userProfile = ConfigUtils.getUserProfile()!;

  @override
  void initState() {
    _textEditingController.addListener(() {
      setState(() {});
    });
    _textEditingController.text = _userProfile.nickname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置名字'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: _enableButton()
                  ? () {
                      _updateNickName();
                    }
                  : null,
              child: Text(
                '完成',
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 8,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: '名字',
                        border: InputBorder.none),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _clearInput();
                    },
                    icon: Icon(Icons.clear)),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _clearInput() {
    _textEditingController.text = '';
    setState(() {});
  }

  bool _enableButton() {
    return _userProfile.nickname != _textEditingController.text.trim() &&
        _textEditingController.text.trim().isNotEmpty;
  }

  void _updateNickName() async {
    var nickname = _textEditingController.text.trim();
    var useCase = UseCaseLocator.updateUserProfileUseCase;
    _userProfile.nickname = nickname;
    var ret = await useCase.execute(nickname, _userProfile.avatar);
    if (ret) {
      // 更新本地信息，退出界面
      Navigator.of(context).pop(_userProfile);
    } else {
      // 提示出错
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("网络请求出错"),
      ));
    }
  }
}
