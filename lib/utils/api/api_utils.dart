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

  // print(decodedResponse);

  // return LoginResponseModel.fromJson(decodedResponse);
}

// Future<http.Response> loadData(int id){
//   return http.get(
//     Uri.parse('https://temply.mathomelab.stream/user/$id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: 
//   );

// }
