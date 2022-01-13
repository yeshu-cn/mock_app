import 'package:lushan/di/repository_locator.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/service/impl/fake/fake_auth_service.dart';
import 'package:lushan/domain/service/impl/fake/fake_user_service.dart';
import 'package:lushan/domain/service/impl/fake/fake_wechat_servcie.dart';
import 'package:lushan/domain/service/user_service.dart';
import 'package:lushan/domain/service/wechat_service.dart';

class ServiceLocator {
  static AuthService _authService = FakeAuthService();
  static UserService _userService = FakeUserService(RepositoryLocator.userRepository);
  static WechatService _wechatService = FakeWechatService();

  static AuthService get authService  => _authService;
  static UserService get userService => _userService;
  static WechatService get wechatService => _wechatService;
}
