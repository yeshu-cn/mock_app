class ScenicSpotPoemDTO {
  String id;
  String title;
  String content;
  String summary;
  String? author;
  String? dynasty;

//<editor-fold desc="Data Methods">

  ScenicSpotPoemDTO({
    required this.id,
    required this.title,
    required this.content,
    required this.summary,
    this.author,
    this.dynasty,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScenicSpotPoemDTO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          summary == other.summary &&
          author == other.author &&
          dynasty == other.dynasty);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      summary.hashCode ^
      author.hashCode ^
      dynasty.hashCode;

  @override
  String toString() {
    return 'ScenicSpotPoemDTO{' +
        ' id: $id,' +
        ' title: $title,' +
        ' content: $content,' +
        ' summary: $summary,' +
        ' author: $author,' +
        ' dynasty: $dynasty,' +
        '}';
  }

  ScenicSpotPoemDTO copyWith({
    String? id,
    String? title,
    String? content,
    String? summary,
    String? author,
    String? dynasty,
  }) {
    return ScenicSpotPoemDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      author: author ?? this.author,
      dynasty: dynasty ?? this.dynasty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'content': this.content,
      'summary': this.summary,
      'author': this.author,
      'dynasty': this.dynasty,
    };
  }

  factory ScenicSpotPoemDTO.fromMap(Map<String, dynamic> map) {
    return ScenicSpotPoemDTO(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      summary: map['summary'] as String,
      author: map['author'] as String,
      dynasty: map['dynasty'] as String,
    );
  }

//</editor-fold>
}