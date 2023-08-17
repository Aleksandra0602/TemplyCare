class LoginResponseModel {
  int id = -1;
  String login = '';
  String email = '';
  String image = '';

  LoginResponseModel({
    required this.id,
    required this.login,
    required this.email,
    required this.image,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    email = json['email'];
    image = json['imageUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login'] = login;
    data['email'] = email;
    data['imageUrl'] = image;
    return data;
  }
}
