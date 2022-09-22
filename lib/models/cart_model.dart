class CartModel {
  String? name;
  double? price;
  String? imageUrl;

  CartModel({
    this.name,
    this.price,
    this.imageUrl,
  });

  factory CartModel.fromMap(map) {
    return CartModel(
      // key: map['key'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      // 'key': key,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
