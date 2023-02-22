class Food {
  final String itemId;
  final String name;
  final String description;
  final String imageLink;

  Food(
      {required this.name,
      required this.description,
      required this.imageLink,
      required this.itemId});

  factory Food.fromRTDB(Map<String, dynamic> json) {
    return Food(
        name: json["name"],
        description: json["description"],
        imageLink: json["imageLink"],
        itemId: json["itemId"]);
  }

  String get foodDetails =>
      "Hello guys, $name is $description the imageLink is $imageLink";
}
