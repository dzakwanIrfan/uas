import 'package:pos_app/models/product.dart';

class Transaction {
  final String id;
  final DateTime date;
  final List<Product> products;
  final double total;

  Transaction({
    required this.id,
    required this.date,
    required this.products,
    required this.total,
  });
}
