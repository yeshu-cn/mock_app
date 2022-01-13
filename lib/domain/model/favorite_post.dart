class FavoritePost {
  String postId;
  String uid;

//<editor-fold desc="Data Methods">

  FavoritePost({
    required this.postId,
    required this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePost &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          uid == other.uid);

  @override
  int get hashCode => postId.hashCode ^ uid.hashCode;

  @override
  String toString() {
    return 'FavoritePost{' + ' postId: $postId,' + ' uid: $uid,' + '}';
  }

  FavoritePost copyWith({
    String? postId,
    String? uid,
  }) {
    return FavoritePost(
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

  factory FavoritePost.fromMap(Map<String, dynamic> map) {
    return FavoritePost(
      postId: map['postId'] as String,
      uid: map['uid'] as String,
    );
  }

//</editor-fold>
}