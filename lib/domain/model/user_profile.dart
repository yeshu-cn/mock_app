import 'package:hive/hive.dart';
part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String avatar;
  @HiveField(2)
  String nickname;

  UserProfile(this.id, this.avatar, this.nickname);
}