// ignore_for_file: use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_pos/models/payment_method_model.dart';
import 'package:simple_pos/shared/theme.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  const PaymentMethodItem({
    Key? key,
    required this.paymentMethod,
    this.onTapEdit,
    this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            paymentMethod.name.toString(),
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTapEdit,
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/pen.png"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapDelete,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/bin.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
