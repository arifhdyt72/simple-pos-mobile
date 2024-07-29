// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/order_method/order_method_bloc.dart';
import 'package:simple_pos/blocs/payment_method/payment_method_bloc.dart';
import 'package:simple_pos/blocs/transaction/transaction_bloc.dart';
import 'package:simple_pos/models/item_cart_model.dart';
import 'package:simple_pos/models/order_method_model.dart';
import 'package:simple_pos/models/payment_method_model.dart';
import 'package:simple_pos/models/transaction_detail_form_model.dart';
import 'package:simple_pos/models/transaction_form_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/services/item_service.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/item_cart.dart';
import 'package:simple_pos/ui/widgets/order_method_item_cart.dart';
import 'package:simple_pos/ui/widgets/payment_method_item_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ItemCartModel> items = [];
  late OrderMethodBloc orderMethodBloc;
  late PaymentMethodBloc paymentMethodBloc;
  OrderMethodModel? selectedOrderMethod;
  PaymentMethodModel? selectedPaymentMethod;
  int subtotal = 0;
  int totalQty = 0;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _getSubtotalAndQty();

    orderMethodBloc = context.read<OrderMethodBloc>()..add(OrderMethodGet());
    paymentMethodBloc = context.read<PaymentMethodBloc>()
      ..add(PaymentMethodGet());
  }

  bool validate() {
    if (items.isEmpty ||
        selectedOrderMethod == null ||
        selectedPaymentMethod == null) {
      return false;
    }

    return true;
  }

  Future<void> _loadProducts() async {
    List<ItemCartModel> loadedProducts = await ItemService().getCart();
    setState(() {
      items = loadedProducts;
    });
  }

  Future<void> _deleteCart() async {
    await ItemService().deleleAllCart();
  }

  Future<void> _getSubtotalAndQty() async {
    List<ItemCartModel> loadedProducts = await ItemService().getCart();
    int total = 0;
    int qty = 0;
    for (ItemCartModel p in loadedProducts) {
      int subtotal = p.basePrice ?? 0;
      subtotal = subtotal * p.qty;
      total = total + subtotal;
      qty = qty + p.qty;
    }

    setState(() {
      subtotal = total;
      totalQty = qty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(),
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionPostSuccess) {
            showSuccessSnackbar(context, "Transaction has been created");
            setState(() {
              _deleteCart();
              _loadProducts();
              _getSubtotalAndQty();
              selectedOrderMethod = null;
              selectedPaymentMethod = null;
              subtotal = 0;
              totalQty = 0;
              totalPrice = 0;
            });
          }
          if (state is TransactionFailed) {
            showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Cart"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "List Item",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.map(
                    (item) {
                      return ItemCart(
                        items: item,
                        onAddItem: () async {
                          int qty = item.qty + 1;
                          await ItemService().updateProductQuantity(
                            item.id ?? 0,
                            qty,
                          );
                          setState(() {
                            _loadProducts();
                            _getSubtotalAndQty();
                          });
                        },
                        onRemoveItem: () async {
                          await ItemService()
                              .reduceProductQuantity(item.id ?? 0, 1);
                          setState(() {
                            _loadProducts();
                            _getSubtotalAndQty();
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Order Method",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<OrderMethodBloc, OrderMethodState>(
                  builder: (context, state) {
                    if (state is OrderMethodSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.orderMethods.map((orderMethod) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOrderMethod = orderMethod;
                                  int price = orderMethod.price ?? 0;
                                  totalPrice = subtotal + price;
                                });
                              },
                              child: OrderMethodItemCart(
                                orderMethod: orderMethod,
                                isSelected:
                                    orderMethod.id == selectedOrderMethod?.id,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Payment Method",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                  builder: (context, state) {
                    if (state is PaymentMethodSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.paymentMethods.map((paymentMethod) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPaymentMethod = paymentMethod;
                                });
                              },
                              child: PaymentMethodItemCart(
                                paymentMethod: paymentMethod,
                                isSelected: paymentMethod.id ==
                                    selectedPaymentMethod?.id,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Detail",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              formatCurrentcy(subtotal),
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              totalQty.toString(),
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Method(${selectedOrderMethod?.name ?? ''})",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              formatCurrentcy(selectedOrderMethod?.price ?? 0),
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Method",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              selectedPaymentMethod != null
                                  ? selectedPaymentMethod!.name.toString()
                                  : '',
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              formatCurrentcy(totalPrice),
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Checkout',
                onPressed: () async {
                  if (validate()) {
                    int storeId = await AuthService().getStoreId();
                    int userId = await AuthService().getUserId();

                    List<TransactionDetailFormModel> transactionDetail = items
                        .map(
                          (item) => TransactionDetailFormModel(
                            itemId: item.id,
                            qty: item.qty,
                          ),
                        )
                        .toList();

                    context.read<TransactionBloc>().add(
                          TransactionPost(
                            TransactionFormModel(
                              paymentMethodId: selectedPaymentMethod!.id,
                              orderMethodId: selectedOrderMethod!.id,
                              storeId: storeId,
                              userId: userId,
                              totalQty: totalQty,
                              total: totalPrice,
                              transactionDetail: transactionDetail,
                            ),
                          ),
                        );
                  } else {
                    showCustomSnackbar(context, 'Semua form harus diisi!');
                  }
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
