class LoginResponseModel {
  String? login;
  String? mail;

  LoginResponseModel({required this.login, required this.mail});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['mail'] = this.mail;
    return data;
  }
}
