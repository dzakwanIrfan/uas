import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = false.obs;
  final RxDouble todaySales = 0.0.obs;
  final RxInt transactionCount = 0.obs;
  final RxInt totalProducts = 0.obs;
  final RxList<FlSpot> weeklySpots = <FlSpot>[].obs;
  final RxList<String> weeklyDates = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final response = await _apiService.getDashboardData();

      if (response['status'] == 'success') {
        final data = response['data'];

        // Update today's summary
        todaySales.value = data['today']['total_sales'].toDouble();
        transactionCount.value = data['today']['transaction_count'];
        totalProducts.value = data['total_products'];

        // Process weekly sales data
        final weeklySales = data['weekly_sales'] as List;
        weeklySpots.clear();
        weeklyDates.clear();

        for (int i = 0; i < weeklySales.length; i++) {
          final sale = weeklySales[i];
          weeklySpots.add(FlSpot(i.toDouble(), sale['total'].toDouble()));
          weeklyDates.add(sale['date']);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dashboard data');
    } finally {
      isLoading.value = false;
    }
  }

  LineChartData get weeklySalesData => LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < weeklyDates.length) {
                  final date = DateTime.parse(weeklyDates[value.toInt()]);
                  return Text(
                    '${date.day}/${date.month}',
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: weeklySpots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData:
                BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
          ),
        ],
      );
}
