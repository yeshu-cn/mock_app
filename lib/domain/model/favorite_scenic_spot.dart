class FavoriteScenicSpot {
  String scenicSpotId;
  String uid;

//<editor-fold desc="Data Methods">

  FavoriteScenicSpot({
    required this.scenicSpotId,
    required this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteScenicSpot &&
          runtimeType == other.runtimeType &&
          scenicSpotId == other.scenicSpotId &&
          uid == other.uid);

  @override
  int get hashCode => scenicSpotId.hashCode ^ uid.hashCode;

  @override
  String toString() {
    return 'FavoriteScenicSpot{' +
        ' scenicSpotId: $scenicSpotId,' +
        ' uid: $uid,' +
        '}';
  }

  FavoriteScenicSpot copyWith({
    String? scenicSpotId,
    String? uid,
  }) {
    return FavoriteScenicSpot(
      scenicSpotId: scenicSpotId ?? this.scenicSpotId,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'scenicSpotId': this.scenicSpotId,
      'uid': this.uid,
    };
  }

  factory FavoriteScenicSpot.fromMap(Map<String, dynamic> map) {
    return FavoriteScenicSpot(
      scenicSpotId: map['scenicSpotId'] as String,
      uid: map['uid'] as String,
    );
  }

//</editor-fold>
}