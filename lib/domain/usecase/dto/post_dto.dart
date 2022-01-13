class PostDTO {
  // 描述
  String desc;

  // 图片
  List<String> images;

  //点赞数
  int likeCount;
  bool like;
  int commentCount;

  // 收藏
  bool favorite;
  // 创建时间
  int time;
  String nickname;
  String avatar;
  String id;

//<editor-fold desc="Data Methods">

  PostDTO({
    required this.desc,
    required this.images,
    required this.likeCount,
    required this.like,
    required this.commentCount,
    required this.favorite,
    required this.time,
    required this.nickname,
    required this.avatar,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostDTO &&
          runtimeType == other.runtimeType &&
          desc == other.desc &&
          images == other.images &&
          likeCount == other.likeCount &&
          like == other.like &&
          commentCount == other.commentCount &&
          favorite == other.favorite &&
          time == other.time &&
          nickname == other.nickname &&
          avatar == other.avatar &&
          id == other.id);

  @override
  int get hashCode =>
      desc.hashCode ^
      images.hashCode ^
      likeCount.hashCode ^
      like.hashCode ^
      commentCount.hashCode ^
      favorite.hashCode ^
      time.hashCode ^
      nickname.hashCode ^
      avatar.hashCode ^
      id.hashCode;

  @override
  String toString() {
    return 'PostDTO{' +
        ' desc: $desc,' +
        ' images: $images,' +
        ' likeCount: $likeCount,' +
        ' like: $like,' +
        ' commentCount: $commentCount,' +
        ' favorite: $favorite,' +
        ' time: $time,' +
        ' nickname: $nickname,' +
        ' avatar: $avatar,' +
        ' id: $id,' +
        '}';
  }

  PostDTO copyWith({
    String? desc,
    List<String>? images,
    int? likeCount,
    bool? like,
    int? commentCount,
    bool? favorite,
    int? time,
    String? nickname,
    String? avatar,
    String? id,
  }) {
    return PostDTO(
      desc: desc ?? this.desc,
      images: images ?? this.images,
      likeCount: likeCount ?? this.likeCount,
      like: like ?? this.like,
      commentCount: commentCount ?? this.commentCount,
      favorite: favorite ?? this.favorite,
      time: time ?? this.time,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desc': this.desc,
      'images': this.images,
      'likeCount': this.likeCount,
      'like': this.like,
      'commentCount': this.commentCount,
      'favorite': this.favorite,
      'time': this.time,
      'nickname': this.nickname,
      'avatar': this.avatar,
      'id': this.id,
    };
  }

  factory PostDTO.fromMap(Map<String, dynamic> map) {
    return PostDTO(
      desc: map['desc'] as String,
      images: map['images'] as List<String>,
      likeCount: map['likeCount'] as int,
      like: map['like'] as bool,
      commentCount: map['commentCount'] as int,
      favorite: map['favorite'] as bool,
      time: map['time'] as int,
      nickname: map['nickname'] as String,
      avatar: map['avatar'] as String,
      id: map['id'] as String,
    );
  }

//</editor-fold>
}