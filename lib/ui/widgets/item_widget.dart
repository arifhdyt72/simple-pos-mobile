// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:simple_pos/models/item_model.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/shared_values.dart';
import 'package:simple_pos/shared/theme.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onTap;

  const ItemWidget({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 197,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              '$baseUrl/${item.photo}',
              width: 172,
              height: 94,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.detail.toString(),
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatCurrentcy(item.basePrice ?? 0),
                      style: blueTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add,
                          color: whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
