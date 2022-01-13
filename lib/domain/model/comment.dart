class Comment {
  String id;
  String postId;
  String content;
  String authorUid;
  String? replyUid;
  int time;

//<editor-fold desc="Data Methods">

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.authorUid,
    this.replyUid,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          content == other.content &&
          authorUid == other.authorUid &&
          replyUid == other.replyUid &&
          time == other.time);

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      content.hashCode ^
      authorUid.hashCode ^
      replyUid.hashCode ^
      time.hashCode;

  @override
  String toString() {
    return 'Comment{' +
        ' id: $id,' +
        ' postId: $postId,' +
        ' content: $content,' +
        ' authorUid: $authorUid,' +
        ' replyUid: $replyUid,' +
        ' time: $time,' +
        '}';
  }

  Comment copyWith({
    String? id,
    String? postId,
    String? content,
    String? authorUid,
    String? replyUid,
    int? time,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      authorUid: authorUid ?? this.authorUid,
      replyUid: replyUid ?? this.replyUid,
      time: time ?? this.time,
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
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      postId: map['postId'] as String,
      content: map['content'] as String,
      authorUid: map['authorUid'] as String,
      replyUid: map['replyUid'] as String,
      time: map['time'] as int,
    );
  }

//</editor-fold>
}