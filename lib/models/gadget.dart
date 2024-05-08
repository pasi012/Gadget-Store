class Gadget {
  final int id;
  final String name;
  final List<dynamic> imageUrl;
  final String price;
  final String description;
  final String category;

  Gadget({required this.id, required this.name, required this.imageUrl, required this.price, required this.description, required this.category, });

  factory Gadget.fromJson(Map<String, dynamic> json) {
    return Gadget(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
    );
  }
}
