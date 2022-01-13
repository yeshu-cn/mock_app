class Post {
  String id;
  String authorId;

  // 描述
  String desc;

  // 本地图片路径
  List<String> images;

  // 创建时间
  int time;
  List<String> tags;

//<editor-fold desc="Data Methods">

  Post({
    required this.id,
    required this.authorId,
    required this.desc,
    required this.images,
    required this.time,
    required this.tags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          authorId == other.authorId &&
          desc == other.desc &&
          images == other.images &&
          time == other.time &&
          tags == other.tags);

  @override
  int get hashCode =>
      id.hashCode ^
      authorId.hashCode ^
      desc.hashCode ^
      images.hashCode ^
      time.hashCode ^
      tags.hashCode;

  @override
  String toString() {
    return 'Post{' +
        ' id: $id,' +
        ' authorId: $authorId,' +
        ' desc: $desc,' +
        ' images: $images,' +
        ' time: $time,' +
        ' tags: $tags,' +
        '}';
  }

  Post copyWith({
    String? id,
    String? authorId,
    String? desc,
    List<String>? images,
    int? time,
    List<String>? tags,
  }) {
    return Post(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      desc: desc ?? this.desc,
      images: images ?? this.images,
      time: time ?? this.time,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'authorId': this.authorId,
      'desc': this.desc,
      'images': this.images,
      'time': this.time,
      'tags': this.tags,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      desc: map['desc'] as String,
      images: map['images'] as List<String>,
      time: map['time'] as int,
      tags: map['tags'] as List<String>,
    );
  }

//</editor-fold>
}
