class TransactionModel {
  final int? id;
  final String? transactionNumber;
  final String? transactionDate;
  final int? total;
  final int? totalQty;
  final String? orderMethodName;
  final int? orderMethodPrice;
  final String? paymentMethodName;
  final String? status;

  TransactionModel({
    this.id,
    this.transactionNumber,
    this.transactionDate,
    this.total,
    this.totalQty,
    this.orderMethodName,
    this.orderMethodPrice,
    this.paymentMethodName,
    this.status,
  });

  factory TransactionModel.formJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        transactionNumber: json['transaction_number'],
        transactionDate: json['transaction_date'],
        total: json['total'],
        totalQty: json['total_qty'],
        orderMethodName: json['order_method_name'],
        orderMethodPrice: json['order_method_price'],
        paymentMethodName: json['payment_method_name'],
        status: json['status'],
      );
}
