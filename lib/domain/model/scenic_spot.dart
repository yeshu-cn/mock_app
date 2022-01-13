class ScenicSpot {
  late String id;
  late String name;
  late String introduction;
  late int score;
  late int attendance;
  late List images;

  ScenicSpot(this.id,
      this.name, this.introduction, this.score, this.attendance, this.images);

  ScenicSpot.create(String name, String introduction)
      : this("", name, introduction, 0, 0, []);

  ScenicSpot.fromJson(Map<String, dynamic> json) {
    this.id = json['\$id'];
    this.name = json['name'];
    this.introduction = json['introduction'];
    this.score = json['score'] as int;
    this.attendance = json['attendance'];
    this.images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['introduction'] = introduction;
    data['score'] = score;
    data['attendance'] = attendance;
    data['images'] = images;
    return data;
  }
}
