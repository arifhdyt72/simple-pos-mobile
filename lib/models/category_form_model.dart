class CategoryFormModel {
  final String? name;
  final int? storeId;
  final String? sourceImage;

  CategoryFormModel({
    this.name,
    this.storeId,
    this.sourceImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'store_id': storeId,
      'source_image': sourceImage,
    };
  }
}
