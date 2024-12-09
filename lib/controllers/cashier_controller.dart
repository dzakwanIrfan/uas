import 'package:get/get.dart';
import '../data/services/api_service.dart';
import '../models/product.dart';

class CashierController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = false.obs;
  final RxList products = [].obs;
  final RxList cartItems = [].obs;
  final RxDouble total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await _apiService.getProducts();

      if (response['status'] == 'success') {
        products.value = (response['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Product product, int quantity) {
    cartItems.add({
      'product_id': product.id,
      'name': product.name,
      'price': product.price,
      'quantity': quantity,
    });
    _calculateTotal();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    _calculateTotal();
  }

  void _calculateTotal() {
    total.value = cartItems.fold(0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  Future<void> processTransaction() async {
    try {
      isLoading.value = true;

      final transactionData = {
        'items': cartItems
            .map((item) => {
                  'product_id': item['product_id'],
                  'quantity': item['quantity'],
                  'price': item['price'],
                })
            .toList(),
      };

      final response = await _apiService.createTransaction(transactionData);

      if (response['status'] == 'success') {
        cartItems.clear();
        _calculateTotal();
        fetchProducts(); // Refresh products to update stock
        Get.snackbar('Success', 'Transaction completed successfully');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Transaction failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to process transaction');
    } finally {
      isLoading.value = false;
    }
  }
}
