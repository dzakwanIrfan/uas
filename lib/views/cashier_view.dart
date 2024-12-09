import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/CashierController.dart';
import '../../widgets/custom_sidebar.dart';

class CashierView extends GetView<CashierController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSidebar(selectedIndex: 1),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cashier',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProductInput(),
                  SizedBox(height: 20),
                  _buildCartList(),
                  _buildTotal(),
                  _buildCheckoutButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
              prefixText: 'Rp ',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                priceController.text.isNotEmpty) {
              controller.addProduct(
                nameController.text,
                double.parse(priceController.text),
              );
              nameController.clear();
              priceController.clear();
            }
          },
          child: Text('Add Product'),
        ),
      ],
    );
  }

  Widget _buildCartList() {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return Card(
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text('Rp ${item.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => controller.updateQuantity(
                          index,
                          item.quantity - 1,
                        ),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => controller.updateQuantity(
                          index,
                          item.quantity + 1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeProduct(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildTotal() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Total: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Obx(() => Text(
                'Rp ${controller.total.value}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => controller.completeTransaction(),
        child: Text('Complete Transaction'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
