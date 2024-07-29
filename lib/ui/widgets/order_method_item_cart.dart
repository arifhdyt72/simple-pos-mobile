// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:simple_pos/models/order_method_model.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';

class OrderMethodItemCart extends StatelessWidget {
  final OrderMethodModel orderMethod;
  final bool isSelected;

  const OrderMethodItemCart({
    Key? key,
    required this.orderMethod,
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
            orderMethod.name.toString(),
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            formatCurrentcy(orderMethod.price ?? 0),
            style: blueTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
