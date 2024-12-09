import 'package:get/get.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;

  void login() {
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      if (username.value == 'admin' && password.value == 'admin') {
        Get.offNamed('/dashboard');
      } else {
        errorMessage.value = 'Invalid username or password';
      }
    } else {
      errorMessage.value = 'Username and password cannot be empty';
    }
  }
}
