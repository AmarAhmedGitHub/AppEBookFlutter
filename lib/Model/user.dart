class User {
  int? id;
  String? name;
  String? username;
  String? specialty;
  String? level;
  String? avatar;
  String? token;

  User(
      {this.id,
      this.name,
      this.username,
      this.specialty,
      this.level,
      this.avatar,
      this.token});

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        username: json['user']['username'],
        specialty: json['user']['specialty'],
        level: json['user']['level'],
        avatar: json['user']['avatar'],
        token: json['token']);
  }
}
