// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:simple_pos/models/payment_method_model.dart';
import 'package:simple_pos/shared/theme.dart';

class PaymentMethodItemCart extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final bool isSelected;
  const PaymentMethodItemCart({
    Key? key,
    required this.paymentMethod,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 55,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: isSelected ? blueColor : whiteColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            paymentMethod.name.toString(),
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
