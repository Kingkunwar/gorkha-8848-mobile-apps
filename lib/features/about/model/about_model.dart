class AboutModel {
  String? details;
  String? title;
  String? image;

  AboutModel({
    this.details,
    this.title,
    this.image,
  });

  AboutModel.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    title = json['title'];
    image = json['image'];
  }
}
