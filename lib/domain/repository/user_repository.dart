import 'package:lushan/domain/model/user.dart';

abstract class UserRepository {
  Future<String> addUser(User user);
  Future<bool> updateUser(User user);
  Future<User?> queryUserById(String uid);
  Future<User?> queryUserByPhone(String phone);
  Future<User?> queryUserByThirdParty(String thirdPartyUid, String thirdPartyType);
}