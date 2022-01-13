import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lushan/di/usecase_locator.dart';
import 'package:lushan/ui/mine/favorite_post_page.dart';
import 'package:lushan/ui/mine/feedback_page.dart';
import 'package:lushan/ui/mine/like_post_page.dart';
import 'package:lushan/ui/mine/profile_page.dart';
import 'package:lushan/ui/user_avatar.dart';
import 'package:lushan/utils/config_utils.dart';

class TabSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabSettingState();
  }
}

class _TabSettingState extends State<TabSetting> {
  var userProfile = ConfigUtils.getUserProfile()!;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  leading: UserAvatar(),
                  title: Text(userProfile.nickname),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: theme.iconTheme.color),
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: theme.dividerColor))),
                  child: ListTile(
                      title: Text('Favorite Post', style: theme.textTheme.bodyText2),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FavoritePostPage()));
                      },
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: theme.iconTheme.color))),
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: theme.dividerColor))),
                  child: ListTile(
                      title: Text('Liked Post', style: theme.textTheme.bodyText2),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LikePostPage()));
                      },
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: theme.iconTheme.color))),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(width: 1, color: theme.dividerColor),
                          bottom:
                              BorderSide(width: 1, color: theme.dividerColor))),
                  child: ListTile(
                      title: Text('Version', style: theme.textTheme.bodyText2),
                      onTap: null,
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: theme.iconTheme.color))),
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: theme.dividerColor))),
                  child: ListTile(
                      title: Text('Feedback', style: theme.textTheme.bodyText2),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FeedbackPage()));
                      },
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: theme.iconTheme.color))),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () async {
                    var ret = await UseCaseLocator.logoutUseCase.execute();
                    if (ret) {
                      ConfigUtils.saveUserToken('');
                      Navigator.of(context).pushNamedAndRemoveUntil('signIn', (route) => false);
                    } else {
                      // 注销失败
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("logout failed"),
                      ));
                    }
                  },
                  child: Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(child: Text('Logout')))),
            ],
          ),
        )
      ],
    );
  }
}
