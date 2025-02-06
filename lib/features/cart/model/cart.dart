import 'package:ecommerce_app/features/homepage/model/products.dart';

class Cart {
  final String id;
  final int quantity;
  final Product product;
  Cart({
    required this.id,
    required this.quantity,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['_id'] as String,
      quantity: map['quantity'] as int,
      product: Product.fromJson(Map<String, dynamic>.from(map['product'])),
    );
  }
}
