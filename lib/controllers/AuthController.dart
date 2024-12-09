import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      error.value = '';

      // Simulate API call - replace with actual authentication
      await Future.delayed(Duration(seconds: 2));

      if (username == 'admin' && password == 'admin123') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', username);
        Get.offAllNamed('/dashboard');
      } else {
        error.value = 'Invalid username or password';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
  }
}
