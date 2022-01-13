import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/service/dto/user_dto.dart';
import 'package:lushan/domain/service/user_service.dart';
import 'package:lushan/domain/service/wechat_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';
import 'package:lushan/utils/log_utils.dart';

class WeChatLoginUseCase {
  WechatService _wechatService;
  AuthService _authService;
  UserService _userService;


  WeChatLoginUseCase(this._wechatService, this._authService, this._userService);

  Future<String?> execute(String wechatToken) async {
    var wechatUser = await _wechatService.userInfo(wechatToken);
    if (null == wechatUser) {
      LogUtils.d('wechat user info is null!');
      return null;
    }
    var user = await _userService.getUserByThirdParty(wechatUser.uid, 'wechat');
    if (null == user) {
      // 注册
      var user = UserDTO(thirdPartType: 'wechat', thirdPartyUid: wechatUser.uid, nickname: wechatUser.nickname, avatar: wechatUser.avatar);
      var uid = await _userService.createUser(user);
      return _authService.generateToken(uid);
    } else {
      // 登录
      return _authService.generateToken(user.uid!);
    }
  }
}