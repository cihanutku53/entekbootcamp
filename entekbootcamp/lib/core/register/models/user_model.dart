class UserModel {
  String? username;
  String? name;
  String? surname;
  String? job;
  String? birthday;
  String? bio;
  List<String>? follows;

  UserModel(
      {this.username,
      this.name,
      this.surname,
      this.job,
      this.birthday,
      this.bio,
      this.follows});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    surname = json['surname'];
    job = json['job'];
    birthday = json['birthday'];
    bio = json['bio'];
    follows = json['follows'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['job'] = this.job;
    data['birthday'] = this.birthday;
    data['bio'] = this.bio;
    data['follows'] = this.follows;
    return data;
  }
}
