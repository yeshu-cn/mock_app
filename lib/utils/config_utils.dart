import 'package:hive/hive.dart';
import 'package:lushan/domain/model/user_profile.dart';

class ConfigUtils {
  static const BOX_NAME_CONFIG = 'config';

  static const _KEY_AVATAR = 'avatarUrl';
  static const _KEY_USER_PROFILE = 'userProfile';
  static const _KEY_USER_TOKEN = 'token';


  static void saveAvatar(String avatarUrl) {
    var box = Hive.box(BOX_NAME_CONFIG);
    box.put(_KEY_AVATAR, avatarUrl);
  }

  static String? getAvatar() {
    var box = Hive.box(BOX_NAME_CONFIG);
    return box.get(_KEY_AVATAR, defaultValue: null);
  }

  static void saveUserProfile(UserProfile userProfile) {
    var box = Hive.box(BOX_NAME_CONFIG);
    box.put(_KEY_USER_PROFILE, userProfile);
  }

  static UserProfile? getUserProfile() {
    var box = Hive.box(BOX_NAME_CONFIG);
    return box.get(_KEY_USER_PROFILE, defaultValue: null);
  }

  static String? getUserToken() {
    var box = Hive.box(BOX_NAME_CONFIG);
    return box.get(_KEY_USER_TOKEN, defaultValue: null);
  }

  static void saveUserToken(String token) {
    var box = Hive.box(BOX_NAME_CONFIG);
    box.put(_KEY_USER_TOKEN, token);
  }
}