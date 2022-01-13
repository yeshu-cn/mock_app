class CommentDTO {
  String id;
  String postId;
  String content;
  String authorUid;
  String? replyUid;
  int time;
  String authorAvatar;
  String authorNickname;
  String replyNickname;

//<editor-fold desc="Data Methods">

  CommentDTO({
    required this.id,
    required this.postId,
    required this.content,
    required this.authorUid,
    this.replyUid,
    required this.time,
    required this.authorAvatar,
    required this.authorNickname,
    required this.replyNickname,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentDTO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          content == other.content &&
          authorUid == other.authorUid &&
          replyUid == other.replyUid &&
          time == other.time &&
          authorAvatar == other.authorAvatar &&
          authorNickname == other.authorNickname &&
          replyNickname == other.replyNickname);

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      content.hashCode ^
      authorUid.hashCode ^
      replyUid.hashCode ^
      time.hashCode ^
      authorAvatar.hashCode ^
      authorNickname.hashCode ^
      replyNickname.hashCode;

  @override
  String toString() {
    return 'CommentDTO{' +
        ' id: $id,' +
        ' postId: $postId,' +
        ' content: $content,' +
        ' authorUid: $authorUid,' +
        ' replyUid: $replyUid,' +
        ' time: $time,' +
        ' authorAvatar: $authorAvatar,' +
        ' authorNickname: $authorNickname,' +
        ' replyNickname: $replyNickname,' +
        '}';
  }

  CommentDTO copyWith({
    String? id,
    String? postId,
    String? content,
    String? authorUid,
    String? replyUid,
    int? time,
    String? authorAvatar,
    String? authorNickname,
    String? replyNickname,
  }) {
    return CommentDTO(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      authorUid: authorUid ?? this.authorUid,
      replyUid: replyUid ?? this.replyUid,
      time: time ?? this.time,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      authorNickname: authorNickname ?? this.authorNickname,
      replyNickname: replyNickname ?? this.replyNickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'postId': this.postId,
      'content': this.content,
      'authorUid': this.authorUid,
      'replyUid': this.replyUid,
      'time': this.time,
      'authorAvatar': this.authorAvatar,
      'authorNickname': this.authorNickname,
      'replyNickname': this.replyNickname,
    };
  }

  factory CommentDTO.fromMap(Map<String, dynamic> map) {
    return CommentDTO(
      id: map['id'] as String,
      postId: map['postId'] as String,
      content: map['content'] as String,
      authorUid: map['authorUid'] as String,
      replyUid: map['replyUid'] as String,
      time: map['time'] as int,
      authorAvatar: map['authorAvatar'] as String,
      authorNickname: map['authorNickname'] as String,
      replyNickname: map['replyNickname'] as String,
    );
  }

//</editor-fold>
}