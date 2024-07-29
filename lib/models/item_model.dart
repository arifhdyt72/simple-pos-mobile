class ItemModel {
  final int? id;
  final String? name;
  final int? categoryId;
  final int? storeId;
  final int? stock;
  final int? basePrice;
  final String? detail;
  final String? photo;

  ItemModel({
    this.id,
    this.name,
    this.categoryId,
    this.storeId,
    this.stock,
    this.basePrice,
    this.detail,
    this.photo,
  });

  factory ItemModel.formJson(Map<String, dynamic> json) => ItemModel(
        id: json['ID'],
        name: json['name'],
        categoryId: json['category_id'],
        storeId: json['store_id'],
        stock: json['stock'],
        basePrice: json['base_price'],
        detail: json['detail'],
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'name': name,
      'category_id': categoryId,
      'store_id': storeId,
      'stock': stock,
      'base_price': basePrice,
      'detail': detail,
      'photo': photo,
    };
  }
}