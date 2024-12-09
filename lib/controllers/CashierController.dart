import 'package:get/get.dart';
import '../models/product.dart';

class CashierController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxDouble total = 0.0.obs;

  void addProduct(String name, double price) {
    // Check if product already exists in cart
    final existingProduct = cartItems.firstWhere(
      (item) => item.name == name,
      orElse: () => Product(name: '', price: 0),
    );

    if (existingProduct.name.isNotEmpty) {
      final index = cartItems.indexOf(existingProduct);
      cartItems[index] = existingProduct.copyWith(
        quantity: existingProduct.quantity + 1,
      );
    } else {
      cartItems.add(Product(name: name, price: price));
    }
    _calculateTotal();
  }

  void removeProduct(int index) {
    cartItems.removeAt(index);
    _calculateTotal();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      cartItems[index] = cartItems[index].copyWith(quantity: quantity);
      _calculateTotal();
    }
  }

  void _calculateTotal() {
    total.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  void clearCart() {
    cartItems.clear();
    total.value = 0;
  }

  void completeTransaction() {
    // Here you would typically save the transaction
    // For now, we'll just clear the cart
    Get.snackbar(
      'Success',
      'Transaction completed successfully!',
      snackPosition: SnackPosition.TOP,
    );
    clearCart();
  }
}
