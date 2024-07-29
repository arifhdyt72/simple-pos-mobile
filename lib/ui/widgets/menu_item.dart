// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:simple_pos/shared/theme.dart';

class MenuItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  const MenuItem({
    Key? key,
    required this.name,
    required this.imageUrl,
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
          Image.asset(
            imageUrl,
            width: 20,
          ),
          Text(
            name,
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
