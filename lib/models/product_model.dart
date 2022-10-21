class Product {
  Product({
    required this.active,
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.type,
    required this.typeString,
    required this.pricePerUnit,
    required this.quantity,
    required this.category,
    required this.approved,
    required this.createdAt,
    required this.v,
  });

  final int active;
  final String id;
  final String userId;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  final String type;
  final String typeString;
  final int pricePerUnit;
  final int quantity;
  final String category;
  final int approved;
  final DateTime createdAt;
  final int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    active: json["active"],
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    type: json["type"],
    typeString: json["typeString"],
    pricePerUnit: json["pricePerUnit"],
    quantity: json["quantity"],
    category: json["category"],
    approved: json["approved"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

}