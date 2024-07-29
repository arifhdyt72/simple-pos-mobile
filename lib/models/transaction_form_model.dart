import 'package:simple_pos/models/transaction_detail_form_model.dart';

class TransactionFormModel {
  final int? paymentMethodId;
  final int? orderMethodId;
  final int? storeId;
  final int? userId;
  final int? totalQty;
  final int? total;
  final List<TransactionDetailFormModel>? transactionDetail;

  TransactionFormModel({
    this.paymentMethodId,
    this.orderMethodId,
    this.storeId,
    this.userId,
    this.totalQty,
    this.total,
    this.transactionDetail,
  });

  Map<String, dynamic> toJson() {
    return {
      'payment_method_id': paymentMethodId,
      'order_method_id': orderMethodId,
      'store_id': storeId,
      'user_id': userId,
      'total_qty': totalQty,
      'total': total,
      'transaction_detail':
          transactionDetail?.map((detail) => detail.toJson()).toList(),
    };
  }
}
