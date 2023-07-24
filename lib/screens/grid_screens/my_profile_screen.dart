import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/my_button.dart';
import 'package:temp_app_v1/screens/ripple_animate_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isPasswordVisible = false;
  String password = 'Password123.';
  String mail = 'mail@magisterka.com';
  String login = 'Student1998';

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
      backgroundColor: MyColor.primary8,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mój profil'),
        backgroundColor: MyColor.primary8,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              height: 480,
              decoration: BoxDecoration(
                color: MyColor.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 4,
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
                              ? const Text(
                                  'Dodaj zdjęcie profilowe',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColor.appBarColor1),
                                )
                              : const Text(
                                  'Zmień zdjęcie profilowe',
                                  style: TextStyle(
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
                          : Container(
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
                                  Container(
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
                      SizedBox(
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
                                  fontSize: 16, color: MyColor.appBarColor1),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              mail,
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.appBarColor1),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                const Text(
                                  'Hasło: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColor.appBarColor1),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                isPasswordVisible
                                    ? Text(
                                        password,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColor.appBarColor1),
                                      )
                                    : Text(
                                        String.fromCharCodes(List.filled(
                                            password.length, 0x2055)),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColor.appBarColor1),
                                      ),
                              ],
                            ),
                            Checkbox(
                              side: BorderSide(
                                  color: MyColor.additionalColor, width: 2),
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
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RippleAnimateScreen()),
                );
              },
              child: MyButton(
                color: MyColor.additionalColor,
                textButton: 'Wyloguj się',
                borderColor: MyColor.additionalColor,
                textColor: MyColor.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
