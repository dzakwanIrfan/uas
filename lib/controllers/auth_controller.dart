import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.login(username, password);

      if (response['status'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', response['data']['id'].toString());
        await prefs.setString('username', response['data']['username']);
        return true;
      } else {
        errorMessage.value = response['message'] ?? 'Login failed';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred';
      return false;
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
