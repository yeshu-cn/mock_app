import 'package:lushan/domain/model/scenic_spot.dart';

class ScenicSpotDTO {
  String id;
  String name;
  String introduction;
  int score;
  int attendance;
  List images;
  bool favorite;

//<editor-fold desc="Data Methods">

  ScenicSpotDTO({
    required this.id,
    required this.name,
    required this.introduction,
    required this.score,
    required this.attendance,
    required this.images,
    required this.favorite,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScenicSpotDTO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          introduction == other.introduction &&
          score == other.score &&
          attendance == other.attendance &&
          images == other.images &&
          favorite == other.favorite);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      introduction.hashCode ^
      score.hashCode ^
      attendance.hashCode ^
      images.hashCode ^
      favorite.hashCode;

  @override
  String toString() {
    return 'ScenicSpotDTO{' +
        ' id: $id,' +
        ' name: $name,' +
        ' introduction: $introduction,' +
        ' score: $score,' +
        ' attendance: $attendance,' +
        ' images: $images,' +
        ' favorite: $favorite,' +
        '}';
  }

  ScenicSpotDTO copyWith({
    String? id,
    String? name,
    String? introduction,
    int? score,
    int? attendance,
    List? images,
    bool? favorite,
  }) {
    return ScenicSpotDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      introduction: introduction ?? this.introduction,
      score: score ?? this.score,
      attendance: attendance ?? this.attendance,
      images: images ?? this.images,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'introduction': this.introduction,
      'score': this.score,
      'attendance': this.attendance,
      'images': this.images,
      'favorite': this.favorite,
    };
  }

  factory ScenicSpotDTO.fromMap(Map<String, dynamic> map) {
    return ScenicSpotDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      introduction: map['introduction'] as String,
      score: map['score'] as int,
      attendance: map['attendance'] as int,
      images: map['images'] as List,
      favorite: map['favorite'] as bool,
    );
  }

//</editor-fold>
}

