/// 负责生成和验证token
abstract class AuthService {
  String generateToken(String uid);
  bool validateToken(String token);
  String? getUid(String token);
  bool deleteToken(String token);
}