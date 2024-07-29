class TransactionDetailFormModel {
  final int? itemId;
  final int? qty;

  TransactionDetailFormModel({
    this.itemId,
    this.qty,
  });

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'qty': qty,
    };
  }
}
