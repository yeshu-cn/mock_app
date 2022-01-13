class LikedPost {
  String postId;
  String uid;

//<editor-fold desc="Data Methods">

  LikedPost({
    required this.postId,
    required this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedPost &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          uid == other.uid);

  @override
  int get hashCode => postId.hashCode ^ uid.hashCode;

  @override
  String toString() {
    return 'LikedPost{' + ' postId: $postId,' + ' uid: $uid,' + '}';
  }

  LikedPost copyWith({
    String? postId,
    String? uid,
  }) {
    return LikedPost(
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': this.postId,
      'uid': this.uid,
    };
  }

  factory LikedPost.fromMap(Map<String, dynamic> map) {
    return LikedPost(
      postId: map['postId'] as String,
      uid: map['uid'] as String,
    );
  }

//</editor-fold>
}