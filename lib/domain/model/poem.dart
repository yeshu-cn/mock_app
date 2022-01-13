class Poem {
  String id;
  String title;
  String author;
  String content;

//<editor-fold desc="Data Methods">

  Poem({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Poem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          author == other.author &&
          content == other.content);

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ author.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'Poem{' +
        ' id: $id,' +
        ' title: $title,' +
        ' author: $author,' +
        ' content: $content,' +
        '}';
  }

  Poem copyWith({
    String? id,
    String? title,
    String? author,
    String? content,
  }) {
    return Poem(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'author': this.author,
      'content': this.content,
    };
  }

  factory Poem.fromMap(Map<String, dynamic> map) {
    return Poem(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      content: map['content'] as String,
    );
  }

//</editor-fold>
}