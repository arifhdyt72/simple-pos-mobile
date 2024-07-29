class PaymentMethodModel {
  final int? id;
  final String? name;

  PaymentMethodModel({
    this.id,
    this.name,
  });

  factory PaymentMethodModel.formJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json['ID'],
        name: json['name'],
      );
}
