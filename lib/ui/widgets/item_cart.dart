// ignore_for_file: use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_pos/models/item_cart_model.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/shared_values.dart';
import 'package:simple_pos/shared/theme.dart';

class ItemCart extends StatelessWidget {
  final ItemCartModel items;
  final VoidCallback? onAddItem;
  final VoidCallback? onRemoveItem;

  const ItemCart({
    Key? key,
    required this.items,
    this.onAddItem,
    this.onRemoveItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.only(
        right: 10,
      ),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              '$baseUrl/${items.photo}',
              width: 90,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 190,
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  items.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  items.detail.toString(),
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  formatCurrentcy(items.basePrice ?? 0),
                  style: blueTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onAddItem,
                child: Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/plus.png'),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Text(
                items.qty.toString(),
                style: greenTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
              GestureDetector(
                onTap: onRemoveItem,
                child: Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/minus.png'),
                    ),
                    shape: BoxShape.circle,
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
