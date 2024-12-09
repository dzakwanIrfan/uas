import 'package:get/get.dart';
import 'package:pos_app/controllers/DashboardController.dart';
import '../models/product.dart';
import '../models/transaction.dart';

class CashierController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxDouble total = 0.0.obs;

  // Reference to DashboardController
  late DashboardController _dashboardController;

  @override
  void onInit() {
    super.onInit();
    _dashboardController = Get.find<DashboardController>();
  }

  void addProduct(String name, double price) {
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
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Error',
        'Cart is empty',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Create new transaction
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      products: List.from(cartItems),
      total: total.value,
    );

    // Update dashboard data
    _dashboardController.addTransaction(transaction);

    // Show success message
    Get.snackbar(
      'Success',
      'Transaction completed successfully!',
      snackPosition: SnackPosition.TOP,
    );

    // Clear cart
    clearCart();
  }
}
