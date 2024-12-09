import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/AuthController.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;

  CustomSidebar({this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Container(
      width: 250,
      color: Colors.blue.shade800,
      child: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              'POS System',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildNavItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            index: 0,
            selectedIndex: selectedIndex,
            onTap: () => Get.offAllNamed('/dashboard'),
          ),
          _buildNavItem(
            icon: Icons.point_of_sale,
            title: 'Cashier',
            index: 1,
            selectedIndex: selectedIndex,
            onTap: () => Get.offAllNamed('/cashier'),
          ),
          Spacer(),
          _buildNavItem(
            icon: Icons.logout,
            title: 'Logout',
            index: -1,
            selectedIndex: selectedIndex,
            onTap: () => authController.logout(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    return Container(
      color: selectedIndex == index ? Colors.blue.shade900 : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}
