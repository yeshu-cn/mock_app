class ScenicSpotPostImageDTO {
  late String url;
  late String postId;
  late bool like;
  late int likeCount;
  late int commentCount;
  late String author;

//<editor-fold desc="Data Methods">

  ScenicSpotPostImageDTO({
    required this.url,
    required this.postId,
    required this.like,
    required this.likeCount,
    required this.commentCount,
    required this.author,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScenicSpotPostImageDTO &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          postId == other.postId &&
          like == other.like &&
          likeCount == other.likeCount &&
          commentCount == other.commentCount &&
          author == other.author);

  @override
  int get hashCode =>
      url.hashCode ^
      postId.hashCode ^
      like.hashCode ^
      likeCount.hashCode ^
      commentCount.hashCode ^
      author.hashCode;

  @override
  String toString() {
    return 'ScenicSpotPostImageDTO{' +
        ' url: $url,' +
        ' postId: $postId,' +
        ' like: $like,' +
        ' likeCount: $likeCount,' +
        ' commentCount: $commentCount,' +
        ' author: $author,' +
        '}';
  }

  ScenicSpotPostImageDTO copyWith({
    String? url,
    String? postId,
    bool? like,
    int? likeCount,
    int? commentCount,
    String? author,
  }) {
    return ScenicSpotPostImageDTO(
      url: url ?? this.url,
      postId: postId ?? this.postId,
      like: like ?? this.like,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'postId': this.postId,
      'like': this.like,
      'likeCount': this.likeCount,
      'commentCount': this.commentCount,
      'author': this.author,
    };
  }

  factory ScenicSpotPostImageDTO.fromMap(Map<String, dynamic> map) {
    return ScenicSpotPostImageDTO(
      url: map['url'] as String,
      postId: map['postId'] as String,
      like: map['like'] as bool,
      likeCount: map['likeCount'] as int,
      commentCount: map['commentCount'] as int,
      author: map['author'] as String,
    );
  }

//</editor-fold>
}