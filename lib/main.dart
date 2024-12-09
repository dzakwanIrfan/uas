import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/AuthController.dart';
import 'package:pos_app/controllers/CashierController.dart';
import 'package:pos_app/controllers/DashboardController.dart';
import 'package:pos_app/views/cashier_view.dart';
import 'package:pos_app/views/dashboard_view.dart';
import 'package:pos_app/views/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(DashboardController());
        Get.put(CashierController());
      }),
      home: LoginView(),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/dashboard', page: () => DashboardView()),
        GetPage(name: '/cashier', page: () => CashierView()),
      ],
    );
  }
}
