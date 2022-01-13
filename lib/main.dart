import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lushan/ui/home_page.dart';
import 'package:lushan/ui/auth/sign_in_page.dart';
import 'package:lushan/ui/auth/sign_up_page.dart';
import 'package:lushan/ui/mine/set_nickname_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lushan/utils/config_utils.dart';

import 'domain/model/user_profile.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());
  await Hive.openBox(ConfigUtils.BOX_NAME_CONFIG);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var token = ConfigUtils.getUserToken();
    return MaterialApp(
      routes: {
        'signIn': (context) => SignInPage(),
        'signUp': (context) => SignUpPage(),
        'home': (context) => HomePage(),
        'setNickName': (context) => SetNickNamePage(),
      },
      title: 'MockApp',
      debugShowCheckedModeBanner: false,
      home: null == token ? SignInPage() : HomePage(),
    );
  }
}
