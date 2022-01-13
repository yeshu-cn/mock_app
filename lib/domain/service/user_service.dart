import 'package:lushan/domain/service/dto/user_dto.dart';

abstract class UserService {
  Future<String> createUser(UserDTO user);
  Future<bool> updateUser(UserDTO user);
  Future<UserDTO?> getUser(String uid);
  Future<UserDTO?> getUserByPhone(String phone);
  Future<UserDTO?> getUserByThirdParty(String thirdPartyUid, String thirdPartyType);
  Future<bool> userExists(String phone);
}