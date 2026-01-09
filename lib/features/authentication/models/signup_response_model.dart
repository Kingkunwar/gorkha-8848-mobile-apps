class SignupResponseModel {
  UserModel? user;
  String? accessToken;

  SignupResponseModel({this.user, this.accessToken});

  SignupResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }
}

class UserModel {
  String? name;
  String? email;
  int? groups;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserModel(
      {this.name,
      this.email,
      this.groups,
      this.updatedAt,
      this.createdAt,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    groups = json['groups'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "groups": groups,
      "created_at": createdAt,
      "id": id,
    };
  }
}
