import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxDouble todayTotal = 0.0.obs;
  final RxInt transactionCount = 0.obs;
  final RxList<double> weeklyData = <double>[].obs;
  final List<String> topProducts = [];
  final List<double> topProductSales = [];

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() {
    try {
      // Simulate API call
      todayTotal.value = 2500000;
      transactionCount.value = 48;

      // Set weekly data
      weeklyData.assignAll([
        1500000,
        2100000,
        1800000,
        2500000,
        1900000,
        2300000,
        2500000,
      ]);

      // Load top products data
      topProducts.clear();
      topProductSales.clear();

      topProducts.addAll([
        'Product A',
        'Product B',
        'Product C',
        'Product D',
        'Product E',
      ]);

      topProductSales.addAll([
        850000,
        720000,
        650000,
        450000,
        380000,
      ]);

      // Notify UI that data has changed
      update();
    } catch (e) {
      print('Error loading dashboard data: $e');
    }
  }

  Future<void> refreshData() async {
    try {
      // Clear existing data
      topProducts.clear();
      topProductSales.clear();
      update();

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));

      // Load new data
      loadDashboardData();
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }
}
