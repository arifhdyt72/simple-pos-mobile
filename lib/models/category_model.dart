class CategoryModel {
  final int? id;
  final String? name;
  final int? storeId;
  final String? icon;

  CategoryModel({
    this.id,
    this.name,
    this.storeId,
    this.icon,
  });

  factory CategoryModel.formJson(Map<String, dynamic> json) => CategoryModel(
        id: json['ID'],
        name: json['name'],
        storeId: json['store_id'],
        icon: json['icon'],
      );
}
