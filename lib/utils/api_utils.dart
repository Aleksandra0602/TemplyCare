import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> registerUser(
    String login, String mail, String password1, String password2) {
  return http.post(
    //dodac
    Uri.parse(''),
    headers: <String, String>{
      'Content-Type': 'aplication/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'login': login,
      'mail': mail,
      'password1': password1,
      'password2': password2,
    }),
  );
}

Future<http.Response> loginUser(String login, String password) {
  return http.post(
    //dodac
    Uri.parse('uri'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'login': login,
      'password': password,
    }),
  );
}
