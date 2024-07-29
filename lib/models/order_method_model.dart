class OrderMethodModel {
  final int? id;
  final String? name;
  final String? markOrder;
  final int? price;

  OrderMethodModel({
    this.id,
    this.name,
    this.markOrder,
    this.price,
  });

  factory OrderMethodModel.formJson(Map<String, dynamic> json) =>
      OrderMethodModel(
        id: json['ID'],
        name: json['name'],
        markOrder: json['mark_order'],
        price: json['price'],
      );
}
