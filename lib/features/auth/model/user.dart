class User {
  String id;
  String name;
  String email;
  String phone;
  String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"],
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      address: map["address"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    };
  }
}
