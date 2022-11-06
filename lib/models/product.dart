class Product {
  final int id;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final price;
  final String description;
  final String category;
  final String image;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  // Now we create the constructor which will accepts the json and
  // returns this model as the object

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}
