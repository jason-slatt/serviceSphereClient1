class Category {
  late final String icon;
  late final String name;

  Category(this.icon, this.name);

  factory Category.fromjson(Map<String, dynamic> json) {
    return Category(json["icon"], json["name"]);
  }

  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(
      json['icon'],
      json['name'],
    );
  }
}


