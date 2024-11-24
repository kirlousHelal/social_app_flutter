class PostModel {
  String? uId;
  String? name;
  String? profileImage;
  String? text;
  String? postImage;
  String? dateTime;

  PostModel({
    required this.uId,
    required this.name,
    required this.text,
    required this.postImage,
    required this.dateTime,
    required this.profileImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['name'] = name;
    data['text'] = text;
    data['postImage'] = postImage;
    data['dateTime'] = dateTime;
    data['profileImage'] = profileImage;

    return data;
  }
}
