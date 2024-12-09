import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cashier_controller.dart';
import '../widgets/sidebar.dart';

class CashierView extends StatelessWidget {
  final CashierController controller = Get.put(CashierController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cashier')),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.productName.value = value,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              onChanged: (value) =>
                  controller.productPrice.value = double.tryParse(value) ?? 0.0,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.addProduct,
              child: Text('Add Product'),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: controller.productList.length,
                    itemBuilder: (context, index) {
                      final product = controller.productList[index];
                      return ListTile(
                        title: Text(product['name']),
                        trailing: Text('\$${product['price']}'),
                      );
                    },
                  ),
                )),
            Obx(() => Text(
                  'Total Price: \$${controller.totalPrice.value}',
                  style: TextStyle(fontSize: 20),
                )),
            ElevatedButton(
              onPressed: controller.completeTransaction,
              child: Text('Complete Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
