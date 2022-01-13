import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/service/user_service.dart';
import 'package:lushan/domain/usecase/dto/login_response_dto.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class LoginUseCase {
  UserService _userService;
  AuthService _authService;

  LoginUseCase(this._userService, this._authService);

  Future<LoginResponseDTO> execute(String phone, password) async {
    var user = await _userService.getUserByPhone(phone);
    if (null == user || user.password != password) {
      return LoginResponseDTO(success: false);
    }
    var token = _authService.generateToken(user.uid!);
    return LoginResponseDTO(
        success: true,
        token: token,
        nickname: user.nickname = user.nickname,
        avatar: user.avatar =user.avatar,
        uid: user.uid);
  }
}
