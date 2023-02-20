class Food {
  final String name;
  final String description;
  final int price;

  Food({required this.name, required this.description, required this.price});

  factory Food.fromRTDB(Map<String, dynamic> json) {
    return Food(
        name: json["name"],
        description: json["description"],
        price: json["price"]);
  }

  String get foodDetails =>
      "Hello guys, $name is $description the price is $price";
}
