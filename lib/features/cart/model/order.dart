import 'package:ecommerce_app/features/cart/model/cart.dart';

class Order {
  final String id;
  final List<Cart> orderItems;
  final num totalPrice;
  final String code;
  final String status;
  Order({
    required this.id,
    required this.orderItems,
    required this.totalPrice,
    required this.code,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderItems': orderItems.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'code': code,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      orderItems:
          List.from(map["orderItems"]).map((e) => Cart.fromMap(e)).toList(),
      totalPrice: map['totalPrice'] as num,
      code: map['code'] as String,
      status: map['status'] as String,
    );
  }
}
