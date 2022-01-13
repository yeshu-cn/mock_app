import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/service/dto/user_dto.dart';
import 'package:lushan/domain/service/user_service.dart';
import 'package:lushan/domain/usecase/dto/register_response_dto.dart';
import 'package:lushan/domain/usecase/usecase.dart';
import 'package:lushan/utils/log_utils.dart';

class RegisterUseCase {
  UserService _userService;
  AuthService _authService;

  RegisterUseCase(this._userService, this._authService);

  Future<RegisterResponseDTO> execute(String phone, String password) async {
    if (!_checkPhone(phone)) {
      LogUtils.d('phone is error');
      return RegisterResponseDTO(success: false);
    }
    if (!_checkPassword(password)) {
      LogUtils.d('password is error');
      return RegisterResponseDTO(success: false);
    }
    var exists = await _userService.userExists(phone);
    if (exists) {
      LogUtils.d('error: the phone is already registered');
      return RegisterResponseDTO(success: false);
    } else {
      var user = UserDTO(phone: _encryptPassword(password), password: password);
      var uid = await _userService.createUser(user);
      var token = _authService.generateToken(uid);
      return RegisterResponseDTO(
          success: true,
          token: token,
          nickname: user.nickname == null ? "" : user.nickname,
          avatar: user.avatar == null ? "" : user.avatar,
          uid: user.uid);
    }
  }

  bool _checkPassword(String pwd) {
    return pwd.isNotEmpty && pwd.length <= 12;
  }

  bool _checkPhone(String phone) {
    return phone.length > 0 && phone.length <= 11;
  }

  String _encryptPassword(String pwd) {
    // todo encrypt password
    return pwd;
  }
}
