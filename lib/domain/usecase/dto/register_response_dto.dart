class RegisterResponseDTO {
  bool success;
  String? token;
  String? nickname;
  String? avatar;
  String? uid;

//<editor-fold desc="Data Methods">

  RegisterResponseDTO({
    required this.success,
    this.token,
    this.nickname,
    this.avatar,
    this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterResponseDTO &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          token == other.token &&
          nickname == other.nickname &&
          avatar == other.avatar &&
          uid == other.uid);

  @override
  int get hashCode =>
      success.hashCode ^
      token.hashCode ^
      nickname.hashCode ^
      avatar.hashCode ^
      uid.hashCode;

  @override
  String toString() {
    return 'RegisterResponseDTO{' +
        ' success: $success,' +
        ' token: $token,' +
        ' nickname: $nickname,' +
        ' avatar: $avatar,' +
        ' uid: $uid,' +
        '}';
  }

  RegisterResponseDTO copyWith({
    bool? success,
    String? token,
    String? nickname,
    String? avatar,
    String? uid,
  }) {
    return RegisterResponseDTO(
      success: success ?? this.success,
      token: token ?? this.token,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': this.success,
      'token': this.token,
      'nickname': this.nickname,
      'avatar': this.avatar,
      'uid': this.uid,
    };
  }

  factory RegisterResponseDTO.fromMap(Map<String, dynamic> map) {
    return RegisterResponseDTO(
      success: map['success'] as bool,
      token: map['token'] as String,
      nickname: map['nickname'] as String,
      avatar: map['avatar'] as String,
      uid: map['uid'] as String,
    );
  }

//</editor-fold>
}