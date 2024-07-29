class OrderMethodFormModel {
  final String? name;
  final String? markOrder;
  final int? price;

  OrderMethodFormModel({
    this.name,
    this.markOrder,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mark_order': markOrder,
      'price': price,
    };
  }
}
