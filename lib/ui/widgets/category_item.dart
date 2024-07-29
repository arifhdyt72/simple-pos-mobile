// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:simple_pos/models/category_model.dart';
import 'package:simple_pos/shared/shared_values.dart';
import 'package:simple_pos/shared/theme.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          category.icon != ""
              ? Image.network(
                  '$baseUrl${category.icon}',
                  width: 20,
                )
              : Image.asset(
                  'assets/empty.png',
                  width: 20,
                ),
          Text(
            category.name.toString(),
            style: blackTextStyle.copyWith(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
