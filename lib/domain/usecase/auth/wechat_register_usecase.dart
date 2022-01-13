import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/service/dto/user_dto.dart';
import 'package:lushan/domain/service/user_service.dart';
import 'package:lushan/domain/service/wechat_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class WechatRegisterUseCase {
  UserService _userService;
  AuthService _authService;
  WechatService _wechatService;

  WechatRegisterUseCase(
      this._userService, this._authService, this._wechatService);

  Future<String?> execute(String wechatToken) async {
    var wechatUser = await _wechatService.userInfo(wechatToken);
    if (null == wechatUser) {
      // 没拿到三方数据，注册失败
      return null;
    }
    var user = UserDTO(thirdPartType: 'wechat', thirdPartyUid: wechatUser.uid, nickname: wechatUser.nickname, avatar: wechatUser.avatar);
    var uid = await _userService.createUser(user);
    return _authService.generateToken(uid);
  }
}