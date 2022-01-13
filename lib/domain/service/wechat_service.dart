import 'package:lushan/domain/service/dto/wechat_user_data.dart';

abstract class WechatService {
  Future<WechatUserData?> userInfo(String token);
}