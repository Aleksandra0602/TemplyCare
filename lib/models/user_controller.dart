import 'package:get/get.dart';

class UserController extends GetxController {
  RxInt id = 0.obs;
  RxString login = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = ''.obs;

  void setUser(
      int userId, String userLogin, String userEmail, String userImageUrl) {
    id.value = userId;
    login.value = userLogin;
    email.value = userEmail;
    imageUrl.value = userImageUrl;
  }

  void updateImageUrl(String userImageUrl) {
    imageUrl.value = userImageUrl;
  }
}
