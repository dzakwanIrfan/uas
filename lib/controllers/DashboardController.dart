import 'package:get/get.dart';
import '../models/transaction.dart';
import '../models/product.dart';

class DashboardController extends GetxController {
  final RxDouble todayTotal = 0.0.obs;
  final RxInt transactionCount = 0.obs;
  final RxList<double> weeklyData = <double>[].obs;
  final List<String> topProducts = [];
  final List<double> topProductSales = [];

  // Store all transactions
  final List<Transaction> _transactions = [];

  @override
  void onInit() {
    super.onInit();
    _initializeWeeklyData();
  }

  void _initializeWeeklyData() {
    weeklyData.assignAll(List.generate(7, (index) => 0.0));
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    _updateDashboardData();
  }

  void _updateDashboardData() {
    // Update today's total and transaction count
    final today = DateTime.now();
    final todayTransactions = _transactions.where((t) =>
        t.date.year == today.year &&
        t.date.month == today.month &&
        t.date.day == today.day);

    todayTotal.value = todayTransactions.fold(0.0, (sum, t) => sum + t.total);
    transactionCount.value = todayTransactions.length;

    // Update weekly data
    _updateWeeklyData();

    // Update top products
    _updateTopProducts();

    // Notify UI of changes
    update();
  }

  void _updateWeeklyData() {
    final now = DateTime.now();
    final weeklyTotals = List.filled(7, 0.0);

    for (var transaction in _transactions) {
      final difference = now.difference(transaction.date).inDays;
      if (difference < 7) {
        weeklyTotals[difference] += transaction.total;
      }
    }

    weeklyData.assignAll(weeklyTotals.reversed.toList());
  }

  void _updateTopProducts() {
    // Create a map to store product totals
    final productTotals = <String, double>{};

    // Calculate total sales for each product
    for (var transaction in _transactions) {
      for (var product in transaction.products) {
        final total = product.price * product.quantity;
        productTotals.update(
          product.name,
          (value) => value + total,
          ifAbsent: () => total,
        );
      }
    }

    // Sort products by total sales
    final sortedProducts = productTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Take top 5 products or less if there are fewer products
    final topCount = sortedProducts.length > 5 ? 5 : sortedProducts.length;

    // Update top products lists
    topProducts.clear();
    topProductSales.clear();

    for (var i = 0; i < topCount; i++) {
      topProducts.add(sortedProducts[i].key);
      topProductSales.add(sortedProducts[i].value);
    }
  }

  Future<void> refreshData() async {
    // Clear data
    todayTotal.value = 0.0;
    transactionCount.value = 0;
    _initializeWeeklyData();
    topProducts.clear();
    topProductSales.clear();

    // Update dashboard
    _updateDashboardData();
  }
}
