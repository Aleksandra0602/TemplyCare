import 'scale_model.dart';
import 'package:get/get.dart';

class ScaleController extends GetxController {
  Rx<int> selectedScale = 1.obs;

  void toggleScale(int value) {
    selectedScale.value = value;
  }

  bool get isCelsius => selectedScale.value == 1;
}
