import 'package:lushan/domain/model/user.dart';
import 'package:lushan/domain/repository/user_repository.dart';
import 'package:lushan/domain/service/dto/user_dto.dart';
import 'package:lushan/domain/service/user_service.dart';
import 'package:uuid/uuid.dart';

class FakeUserService extends UserService {
  UserRepository _userRepository;

  FakeUserService(this._userRepository);

  @override
  Future<String> createUser(UserDTO user) async {
    user.uid = Uuid().v4();
    User item = User.fromMap(user.toMap());
    return await _userRepository.addUser(item);
  }

  @override
  Future<UserDTO?> getUser(String uid) async {
    var user = await _userRepository.queryUserById(uid);
    if (null == user) {
      return null;
    } else {
      return UserDTO.fromMap(user.toMap());
    }
  }

  @override
  Future<UserDTO?> getUserByPhone(String phone) async {
    var user = await _userRepository.queryUserByPhone(phone);
    if (null == user) {
      return null;
    } else {
      return UserDTO.fromMap(user.toMap());
    }
  }

  @override
  Future<UserDTO?> getUserByThirdParty(
      String thirdPartyUid, String thirdPartyType) async {
    var user = await _userRepository.queryUserByThirdParty(
        thirdPartyUid, thirdPartyType);
    if (null == user) {
      return null;
    } else {
      return UserDTO.fromMap(user.toMap());
    }
  }

  @override
  Future<bool> userExists(String phone) async {
    var user = await _userRepository.queryUserByPhone(phone);
    return user != null ? true : false;
  }

  @override
  Future<bool> updateUser(UserDTO user) async {
    var item = User.fromMap(user.toMap());
    return await _userRepository.updateUser(item);
  }
}
