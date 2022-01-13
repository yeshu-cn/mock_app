import 'package:flutter/material.dart';
import 'package:lushan/domain/model/user_profile.dart';
import 'package:lushan/ui/mine/set_avatar_page.dart';
import 'package:lushan/ui/user_avatar.dart';
import 'package:lushan/utils/config_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile _userProfile = ConfigUtils.getUserProfile()!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () async {
              var userProfile = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SetAvatarPage()));
              if (null != userProfile) {
                _userProfile = _userProfile;
                setState(() {
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text('头像', style: Theme.of(context).textTheme.subtitle1),
                  Spacer(),
                  UserAvatar(),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () async {
              var ret = await Navigator.of(context).pushNamed('setNickName');
              if (null != ret) {
                _userProfile = ret as UserProfile;
                setState(() {});
              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text('昵称', style: Theme.of(context).textTheme.subtitle1),
                  Spacer(),
                  Text(
                    _userProfile.nickname,
                    style: Theme.of(context).textTheme.subtitle1,
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
        ],
      ),
    );
  }
}
