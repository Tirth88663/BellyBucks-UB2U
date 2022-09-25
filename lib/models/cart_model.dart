class CartModel {
  String? name;
  int? price;
  String? imageUrl;
  int? quantity;

  CartModel({
    this.name,
    this.price,
    this.imageUrl,
    this.quantity,
  });

  factory CartModel.fromMap(map) {
    return CartModel(
        // key: map['key'],
        name: map['name'],
        price: map['price'],
        imageUrl: map['imageUrl'],
        quantity: map['quantity']);
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      // 'key': key,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
