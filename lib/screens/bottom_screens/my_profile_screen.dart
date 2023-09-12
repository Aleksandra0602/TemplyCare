import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_v1/models/login_response_model.dart';
import 'package:temp_app_v1/models/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temp_app_v1/utils/api/api_utils.dart';

import 'package:temp_app_v1/widgets/bars_and_buttons/my_snack_bar.dart';
import 'package:temp_app_v1/widgets/profile_dialog.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key, this.device}) : super(key: key);
  final BluetoothDevice? device;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isPasswordVisible = false;
  final UserController userController = Get.put(UserController());

  final _passwordCheckController = TextEditingController();
  final _passwordController = TextEditingController();

  File? storedImage;

  Future getPhoto(int idUser) async {
    final photo = ImagePicker();
    final profilePhoto =
        await photo.pickImage(source: ImageSource.gallery, maxWidth: 600);

    setState(() {
      storedImage = File(profilePhoto!.path);
      changePicture(idUser, storedImage);
    });
  }

  void changePicture(int idUser, File? storedImage) async {
    http.Response response = await changeImage(idUser, storedImage);
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final dataUser = LoginResponseModel.fromJson(decodedResponse);
      _onChangeImage(dataUser);
    }
  }

  void _onChangeImage(LoginResponseModel responseModel) {
    userController.updateImageUrl(responseModel.image);
  }

  void changePass(int idUser, String password, String password2,
      BuildContext context) async {
    if (password.compareTo(password2) == 0) {
      http.Response responsePassword = await changePassword(idUser, password);

      if (responsePassword.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
            textSnackBar: AppLocalizations.of(context)!.passwordChanged,
            context: context));
        Navigator.of(context).pop();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
          textSnackBar: AppLocalizations.of(context)!.errorPasswordChange,
          context: context));
    }
  }

  late String loginUser;
  late String mailUSer;
  late String imageUSer;
  late int idUser;

  @override
  Widget build(BuildContext context) {
    idUser = userController.id.value;
    loginUser = userController.login.value;
    mailUSer = userController.email.value;
    imageUSer = userController.imageUrl.value;

    return ProfileDialog(
      loginUser: loginUser,
      mailUSer: mailUSer,
      imageUSer: imageUSer,
      idUser: idUser,
      functionGetPhoto: getPhoto,
      changePass: changePass,
      storedImage: storedImage,
      textEditingController: _passwordController,
      textEditingController2: _passwordCheckController,
    );
  }
}
