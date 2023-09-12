import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temp_app_v1/widgets/textformfields/password_field.dart';

import '../screens/log_sign_screens/log_sign_screen.dart';

class ProfileDialog extends StatelessWidget {
  final String loginUser;
  final String mailUSer;
  final String imageUSer;
  final int idUser;
  final Function(int) functionGetPhoto;
  final Function(int, String, String, BuildContext) changePass;
  final File? storedImage;
  final TextEditingController textEditingController;
  final TextEditingController textEditingController2;

  ProfileDialog(
      {Key? key,
      required this.loginUser,
      required this.mailUSer,
      required this.imageUSer,
      required this.idUser,
      this.storedImage,
      required this.textEditingController,
      required this.textEditingController2,
      required this.functionGetPhoto,
      required this.changePass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? MyColor.darkBackgroundColor.withRed(60).withBlue(60).withGreen(60)
          : MyColor.primary6,
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
                      height: 500,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: Get.isDarkMode
                            ? []
                            : const [
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
                                  Text(
                                    AppLocalizations.of(context)!.changePic,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Get.isDarkMode
                                            ? MyColor.backgroundColor
                                                .withOpacity(0.7)
                                            : MyColor.appBarColor1),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Get.isDarkMode
                                          ? MyColor.darkAdditionalColor
                                          : MyColor.additionalColor,
                                    ),
                                    onPressed: () => functionGetPhoto(idUser),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              storedImage == null
                                  ? SizedBox(
                                      height: 180,
                                      width: 180,
                                      child: Stack(children: [
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
                                            child: Image.network(
                                              imageUSer,
                                            ),
                                          ),
                                        ),
                                      ]),
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
                                loginUser,
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
                                    Text(
                                      'E-mail: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Get.isDarkMode
                                              ? MyColor.backgroundColor
                                                  .withOpacity(0.7)
                                              : MyColor.appBarColor1),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      mailUSer,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Get.isDarkMode
                                              ? MyColor.backgroundColor
                                                  .withOpacity(0.7)
                                              : MyColor.appBarColor1),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    PasswordField(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .newPassword,
                                                        Icons.password,
                                                        textEditingController),
                                                    PasswordField(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .repeatNewPassword,
                                                        Icons.password,
                                                        textEditingController2),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => changePass(
                                                        idUser,
                                                        textEditingController
                                                            .text,
                                                        textEditingController2
                                                            .text,
                                                        context),
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
                                          color: MyColor.primary8,
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
                      height: 60,
                    ),
                  ],
                ),
                Positioned(
                  top: 480,
                  height: 64,
                  width: 340,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogSignScreen()),
                      );
                    },
                    child: MyButton(
                      color: Get.isDarkMode
                          ? MyColor.darkAdditionalColor
                          : MyColor.additionalColor,
                      textButton: AppLocalizations.of(context)!.logoutButton,
                      borderColor: Get.isDarkMode
                          ? MyColor.darkAdditionalColor
                          : MyColor.additionalColor,
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
