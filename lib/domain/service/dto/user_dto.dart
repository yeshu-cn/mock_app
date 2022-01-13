class UserDTO {
  String? uid;
  String? phone;
  String? password;
  String? thirdPartyUid;
  String? thirdPartType;
  String nickname;
  String avatar;

//<editor-fold desc="Data Methods">

  UserDTO({
    this.uid,
    this.phone,
    this.password,
    this.thirdPartyUid,
    this.thirdPartType,
    this.nickname = '',
    this.avatar = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDTO &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          phone == other.phone &&
          password == other.password &&
          thirdPartyUid == other.thirdPartyUid &&
          thirdPartType == other.thirdPartType &&
          nickname == other.nickname &&
          avatar == other.avatar);

  @override
  int get hashCode =>
      uid.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      thirdPartyUid.hashCode ^
      thirdPartType.hashCode ^
      nickname.hashCode ^
      avatar.hashCode;

  @override
  String toString() {
    return 'UserDTO{' +
        ' uid: $uid,' +
        ' phone: $phone,' +
        ' password: $password,' +
        ' thirdPartyUid: $thirdPartyUid,' +
        ' thirdPartType: $thirdPartType,' +
        ' nickname: $nickname,' +
        ' avatar: $avatar,' +
        '}';
  }

  UserDTO copyWith({
    String? uid,
    String? phone,
    String? password,
    String? thirdPartyUid,
    String? thirdPartType,
    String? nickname,
    String? avatar,
  }) {
    return UserDTO(
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      thirdPartyUid: thirdPartyUid ?? this.thirdPartyUid,
      thirdPartType: thirdPartType ?? this.thirdPartType,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'phone': this.phone,
      'password': this.password,
      'thirdPartyUid': this.thirdPartyUid,
      'thirdPartType': this.thirdPartType,
      'nickname': this.nickname,
      'avatar': this.avatar,
    };
  }

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      uid: map['uid'] as String?,
      phone: map['phone'] as String?,
      password: map['password'] as String?,
      thirdPartyUid: map['thirdPartyUid'] as String?,
      thirdPartType: map['thirdPartType'] as String?,
      nickname: map['nickname'] as String,
      avatar: map['avatar'] as String,
    );
  }

//</editor-fold>
}