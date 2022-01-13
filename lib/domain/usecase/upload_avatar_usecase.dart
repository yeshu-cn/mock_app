import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class UploadAvatarUseCase extends UseCase {
  final AuthService _authService;

  UploadAvatarUseCase(this._authService);

  Future<String> execute(String filePath) async {
    return filePath;
  }
}
