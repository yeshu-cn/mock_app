import 'package:lushan/domain/repository/user_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class UpdateUserProfileUseCase extends UseCase {
  final UserRepository _userRepository;
  final AuthService _authService;


  UpdateUserProfileUseCase(this._userRepository, this._authService);

  Future<bool> execute(String nickname, String avatar) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    var user = await _userRepository.queryUserById(uid);
    if (null == user) {
      throw Exception('user is null');
    }
    user.avatar = avatar;
    user.nickname = nickname;
    _userRepository.updateUser(user);
    return true;
  }
}
