class PaymentMethodFormModel {
  final String? name;

  PaymentMethodFormModel({
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
