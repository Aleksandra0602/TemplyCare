import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/my_button.dart';
import 'package:temp_app_v1/screens/ripple_animate_screen.dart';
import 'package:temp_app_v1/widgets/password_field.dart';

import 'categories_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isPasswordVisible = false;
  String password = 'Password123.';
  String mail = 'Student1998@gmail.com';
  String login = 'Student1998';
  final _passwordCheckController = TextEditingController();
  final _passwordController = TextEditingController();

  File? storedImage;

  Future getPhoto() async {
    final photo = ImagePicker();
    final profilePhoto =
        await photo.pickImage(source: ImageSource.gallery, maxWidth: 600);

    setState(() {
      storedImage = File(profilePhoto!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primary6,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.appBarProfile),
        backgroundColor: MyColor.primary6,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      // alignment: Alignment.center,
                      height: 540,
                      decoration: BoxDecoration(
                        color: MyColor.backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  storedImage == null
                                      ? Text(
                                          AppLocalizations.of(context)!.addPic,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: MyColor.appBarColor1),
                                        )
                                      : Text(
                                          AppLocalizations.of(context)!
                                              .changePic,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: MyColor.appBarColor1),
                                        ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: MyColor.additionalColor,
                                    ),
                                    onPressed: getPhoto,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              storedImage == null
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.grey.shade200,
                                      size: 150,
                                    )
                                  : SizedBox(
                                      height: 180,
                                      width: 180,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 15,
                                                    spreadRadius: 5),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 180,
                                            width: 180,
                                            child: ClipOval(
                                              child: Image.file(
                                                storedImage!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                login,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: MyColor.primary7,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      'E-mail: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.appBarColor1),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      mail,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: MyColor.appBarColor1),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.password,
                                          color: MyColor.primary7,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .password,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: MyColor.appBarColor1),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        isPasswordVisible
                                            ? Text(
                                                password,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        MyColor.appBarColor1),
                                              )
                                            : Text(
                                                String.fromCharCodes(
                                                    List.filled(password.length,
                                                        0x2055)),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        MyColor.appBarColor1),
                                              ),
                                      ],
                                    ),
                                    Checkbox(
                                      side: const BorderSide(
                                          color: MyColor.additionalColor,
                                          width: 2),
                                      focusColor: MyColor.appBarColor1,
                                      checkColor: MyColor.backgroundColor,
                                      activeColor: MyColor.additionalColor,
                                      value: isPasswordVisible,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isPasswordVisible = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .manage),
                                              content: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                // padding: EdgeInsets.all(4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    PasswordField(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .newPassword,
                                                        Icons.password,
                                                        _passwordController),
                                                    PasswordField(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .repeatNewPassword,
                                                        Icons.password,
                                                        _passwordCheckController),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .alertButton))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .changePassowrd,
                                      style: const TextStyle(
                                          color: MyColor.appBarColor3,
                                          fontStyle: FontStyle.italic),
                                    )),
                              ),
                              const SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
                Positioned(
                  top: 520,
                  height: 64,
                  width: 340,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RippleAnimateScreen()),
                      );
                    },
                    child: MyButton(
                      color: MyColor.additionalColor,
                      textButton: AppLocalizations.of(context)!.logoutButton,
                      borderColor: MyColor.additionalColor,
                      textColor: MyColor.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
