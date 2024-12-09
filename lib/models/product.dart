class Product {
  final String name;
  final double price;
  final int quantity;

  Product({
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  Product copyWith({
    String? name,
    double? price,
    int? quantity,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
