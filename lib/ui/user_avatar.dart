import 'package:flutter/material.dart';
import 'package:lushan/utils/app_constant.dart';
import 'package:lushan/utils/config_utils.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  var _userProfile = ConfigUtils.getUserProfile()!;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: _buildAvatarImage(),
    );
  }

  Widget _buildAvatarImage() {
    if (_userProfile.avatar.isEmpty) {
      return Image(
        fit: BoxFit.fill,
        image: AssetImage(AppConstant.defaultAvatarPath),
        height: 60,
        width: 60,
      );
    } else {
      return Image(
        fit: BoxFit.fill,
        image: AssetImage(_userProfile.avatar),
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
}
