class ItemSearchModel {
  final String? name;

  ItemSearchModel({
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}
