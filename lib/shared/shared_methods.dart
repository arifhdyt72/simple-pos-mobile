import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

void showSuccessSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: greenColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String formatCurrentcy(
  num number, {
  String symbol = 'Rp. ',
}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

Future<XFile?> selectImage() async {
  XFile? selectImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  return selectImage;
}

Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64String = base64Encode(imageBytes);
  return base64String;
}
