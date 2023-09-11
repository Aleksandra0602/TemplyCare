import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<http.Response> registerUser(
    String login, String email, String password, File? image) {
  final Map<String, dynamic> requestBody = {
    'login': login,
    'email': email,
    'password': password,
  };

  if (image != null) {
    final bytes = File(image.path).readAsBytesSync();
    requestBody['image'] = base64Encode(bytes);
  } else {
    requestBody['image'] = null;
  }

  return http.post(
    Uri.parse('https://temply.mathomelab.stream/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );
}

Future<http.Response> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://temply.mathomelab.stream/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  return response;
}

Future<http.Response> changeImage(int id, File? storedImage) async {
  final bytes = File(storedImage!.path).readAsBytesSync();
  final base64Image = base64Encode(bytes);

  final Map<String, dynamic> requestBody = {
    'id': id,
    'image': base64Image,
  };

  final response = await http.put(
    Uri.parse('https://temply.mathomelab.stream/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );

  return response;
}

Future<http.Response> changePassword(int id, String password) async {
  final Map<String, dynamic> requestBody = {
    'id': id,
    'password': password,
  };

  final response = await http.put(
    Uri.parse('https://temply.mathomelab.stream/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );
  return response;
}
