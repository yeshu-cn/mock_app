class WechatUserData {
  String uid;
  String nickname;
  String avatar;

//<editor-fold desc="Data Methods">

  WechatUserData({
    required this.uid,
    this.nickname = '',
    this.avatar = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WechatUserData &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          nickname == other.nickname &&
          avatar == other.avatar);

  @override
  int get hashCode => uid.hashCode ^ nickname.hashCode ^ avatar.hashCode;

  @override
  String toString() {
    return 'WechatUserData{' +
        ' uid: $uid,' +
        ' nickname: $nickname,' +
        ' avatar: $avatar,' +
        '}';
  }

  WechatUserData copyWith({
    String? uid,
    String? nickname,
    String? avatar,
  }) {
    return WechatUserData(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'nickname': this.nickname,
      'avatar': this.avatar,
    };
  }

  factory WechatUserData.fromMap(Map<String, dynamic> map) {
    return WechatUserData(
      uid: map['uid'] as String,
      nickname: map['nickname'] as String,
      avatar: map['avatar'] as String,
    );
  }

//</editor-fold>
}