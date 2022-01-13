import 'package:lushan/domain/service/dto/wechat_user_data.dart';
import 'package:lushan/domain/service/wechat_service.dart';

class FakeWechatService implements WechatService {

  @override
  Future<WechatUserData?> userInfo(String token) async {

    return WechatUserData(uid: 'wechatUid', nickname: "yeshu");
  }

}