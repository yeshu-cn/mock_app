import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class LogoutUseCase extends UseCase {
  final AuthService _authService;


  LogoutUseCase(this._authService);

  Future<bool> execute() async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    return true;
  }
}