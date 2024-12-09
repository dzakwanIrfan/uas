import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/DashboardController.dart';
import '../../widgets/custom_sidebar.dart';
import '../../widgets/chart_widgets.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSidebar(selectedIndex: 0),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSummaryCards(),
                  SizedBox(height: 20),
                  _buildWeeklyChart(),
                  SizedBox(height: 20),
                  _buildTopProducts(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => _buildSummaryCard(
                'Today\'s Sales',
                'Rp ${controller.todayTotal.value.toStringAsFixed(0)}',
                Icons.monetization_on,
                Colors.green,
              )),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Obx(() => _buildSummaryCard(
                'Transactions',
                '${controller.transactionCount.value}',
                Icons.receipt_long,
                Colors.blue,
              )),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Icon(icon, color: color),
            ],
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Sales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GetBuilder<DashboardController>(
            // Using GetBuilder instead of Obx
            builder: (controller) {
              return controller.weeklyData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : WeeklyBarChart(data: controller.weeklyData);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopProducts() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GetBuilder<DashboardController>(
            builder: (controller) {
              if (controller.topProducts.isEmpty ||
                  controller.topProductSales.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TopProductsPieChart(
                      products: controller.topProducts,
                      sales: controller.topProductSales,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 300, // Set a fixed height or adjust as needed
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.topProducts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors
                                    .primaries[index % Colors.primaries.length],
                                shape: BoxShape.circle,
                              ),
                            ),
                            title: Text(
                              controller.topProducts[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Rp ${controller.topProductSales[index].toStringAsFixed(0)}',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
