class FeedbackItem {
  String content;
  String contact;
  List images;

  FeedbackItem(this.content, this.images, this.contact);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    data['images'] = images;
    data['contact'] = contact;
    return data;
  }
}