class UserModel {
  String? uId;
  String? name;
  String? email;
  String? phone;
  String? bio;
  String? profileImage;
  String? coverImage;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.profileImage,
    required this.coverImage,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['bio'] = bio;
    data['profileImage'] = profileImage;
    data['coverImage'] = coverImage;

    return data;
  }
}
