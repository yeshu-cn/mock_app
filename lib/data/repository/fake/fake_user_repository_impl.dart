import 'package:collection/collection.dart';
import 'package:lushan/domain/model/user.dart';
import 'package:lushan/domain/repository/user_repository.dart';

class FakeUserRepositoryImpl implements UserRepository {
  List<User> _data = [];

  @override
  Future<String> addUser(User user) async {
    _data.add(user);
    return user.uid;
  }

  @override
  Future<User?> queryUserById(String uid) async {
    return _data.firstWhereOrNull((element) => element.uid == uid);
  }

  @override
  Future<User?> queryUserByPhone(String phone) async {
    return _data.firstWhereOrNull((element) => element.phone == phone);
  }

  @override
  Future<User?> queryUserByThirdParty(String thirdPartyUid, String thirdPartyType) async {
    return _data.firstWhereOrNull((element) => element.thirdPartType == thirdPartyType && element.thirdPartyUid == thirdPartyUid);
  }

  @override
  Future<bool> updateUser(User user) async {
    var item = await queryUserById(user.uid);
    if (null == item) {
      return false;
    } else {
      item = user;
      return true;
    }
  }

}