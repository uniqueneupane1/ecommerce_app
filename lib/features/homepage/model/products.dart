// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String brand;
  final num price;
  final List<String> catagories;
  final bool addedToCart;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.brand,
    required this.price,
    required this.catagories,
    required this.addedToCart,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"] ?? "",
        image: json["image"],
        brand: json["brand"] ?? "",
        price: json["price"],
        addedToCart: json["added_in_cart"] ?? false,
        catagories:
            List.from(json["catagories"]).map((x) => x.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "image": image,
        "brand": brand,
        "price": price,
        "catagories": catagories,
        "added_in_cart": addedToCart,
      };

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? brand,
    num? price,
    List<String>? catagories,
    bool? addedToCart,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      catagories: catagories ?? this.catagories,
      addedToCart: addedToCart ?? this.addedToCart,
    );
  }
}
