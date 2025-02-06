class InitiateOrderParam {
  final String fullName;
  final String phoneNo;
  final String city;
  final String address;

  InitiateOrderParam({
    required this.fullName,
    required this.phoneNo,
    required this.city,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      "address": address,
      "city": city,
      "phone": phoneNo,
      "fullName": fullName,
    };
  }
}
