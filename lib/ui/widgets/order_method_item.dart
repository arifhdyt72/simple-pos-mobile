// ignore_for_file: use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_pos/models/order_method_model.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';

class OrderMethodItem extends StatelessWidget {
  final OrderMethodModel orderMethod;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;
  const OrderMethodItem({
    Key? key,
    required this.orderMethod,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${orderMethod.name} (${orderMethod.markOrder})",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                formatCurrentcy(orderMethod.price ?? 0),
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                ),
              )
            ],
          ),
          Column(
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
                onDoubleTap: onTapDelete,
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
          )
        ],
      ),
    );
  }
}
