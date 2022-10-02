class OrderModel {
  String? customerName;
  String? mobileNumber;
  Map<String, int>? products;

  OrderModel({
    this.customerName,
    this.mobileNumber,
    this.products,
  });

  factory OrderModel.fromMap(map) {
    return OrderModel(
      customerName: map['customerName'],
      mobileNumber: map['mobileNumber'],
      products: map['products'],
    );
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'mobileNumber': mobileNumber,
      'products': products,
    };
  }
}
