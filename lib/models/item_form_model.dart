class ItemFormModel {
  final String? name;
  final int? categoryId;
  final int? storeId;
  final int? stock;
  final int? basePrice;
  final String? detail;
  final String? sourceImage;

  ItemFormModel({
    this.name,
    this.categoryId,
    this.storeId,
    this.stock,
    this.basePrice,
    this.detail,
    this.sourceImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category_id': categoryId,
      'store_id': storeId,
      'stock': stock,
      'base_price': basePrice,
      'detail': detail,
      'source_image': sourceImage,
    };
  }
}
