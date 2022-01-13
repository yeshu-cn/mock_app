
abstract class LoginService {
  Future<bool> login(String email, String password);

  Future<bool> logout();
}