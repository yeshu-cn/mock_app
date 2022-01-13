import 'package:lushan/domain/service/auth_service.dart';

class FakeAuthService implements AuthService {
  // token, uid
  Map<String, String> map = {};

  @override
  String generateToken(String uid) {
    var token = 'uid:${DateTime.now().millisecondsSinceEpoch}';
    map[token] = uid;
    return token;
  }

  @override
  bool validateToken(String token) {
    return map.containsKey(token);
  }

  @override
  String? getUid(String token) {
    return map[token];
  }

  @override
  bool deleteToken(String token) {
    map.remove(token);
    return true;
  }

}