import 'package:get/get.dart';

class CashierController extends GetxController {
  var productName = ''.obs;
  var productPrice = 0.0.obs;
  var productList = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;

  void addProduct() {
    if (productName.value.isNotEmpty && productPrice.value > 0) {
      productList.add({'name': productName.value, 'price': productPrice.value});
      totalPrice.value += productPrice.value;
      productName.value = '';
      productPrice.value = 0.0;
    }
  }

  void completeTransaction() {
    productList.clear();
    totalPrice.value = 0.0;
  }
}
