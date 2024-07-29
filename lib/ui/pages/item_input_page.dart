// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_pos/blocs/category/category_bloc.dart';
import 'package:simple_pos/blocs/item/item_bloc.dart';
import 'package:simple_pos/models/item_form_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/forms.dart';

class ItemInputPage extends StatefulWidget {
  const ItemInputPage({super.key});

  @override
  State<ItemInputPage> createState() => _ItemInputPageState();
}

class _ItemInputPageState extends State<ItemInputPage> {
  final nameController = TextEditingController(text: '');
  final stockController = TextEditingController(text: '');
  final basePriceController = TextEditingController(text: '');
  final detailController = TextEditingController(text: '');
  XFile? selectedImage;
  int? _selectedCategory;

  bool validate() {
    if (nameController.text.isEmpty ||
        stockController.text.isEmpty ||
        basePriceController.text.isEmpty ||
        detailController.text.isEmpty ||
        _selectedCategory == null ||
        selectedImage == null) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(),
      child: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemPostSuccess) {
            showSuccessSnackbar(
              context,
              'Item has been added!',
            );

            setState(() {
              nameController.text = '';
              stockController.text = '';
              basePriceController.text = '';
              detailController.text = '';
              _selectedCategory = null;
              selectedImage = null;
            });
          }

          if (state is ItemFailed) {
            showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is ItemLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Form Item"),
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
              title: const Text("Form Item"),
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
                Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 50,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final image = await selectImage();
                          setState(() {
                            selectedImage = image;
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: lightBackgroudColor,
                            shape: BoxShape.circle,
                            image: selectedImage == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(
                                      File(selectedImage!.path),
                                    ),
                                  ),
                          ),
                          child: selectedImage != null
                              ? null
                              : Image.asset(
                                  "assets/ic_upload.png",
                                  width: 32,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        title: 'Item Name',
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocProvider(
                        create: (context) => CategoryBloc()..add(CategoryGet()),
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            if (state is CategorySuccess) {
                              return Container(
                                width: double.infinity,
                                height: 50,
                                margin: const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Category',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  value: _selectedCategory,
                                  onChanged: (int? newKey) {
                                    setState(() {
                                      _selectedCategory = newKey;
                                    });
                                  },
                                  items: state.categories.map((category) {
                                    return DropdownMenuItem<int>(
                                      value: category.id,
                                      child: Text(category.name!),
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      CustomFormField(
                        title: 'Item Stock',
                        keyboardType: TextInputType.number,
                        controller: stockController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        title: 'Base Price',
                        keyboardType: TextInputType.number,
                        controller: basePriceController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        title: 'Detail',
                        maxLines: 3,
                        controller: detailController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Submit',
                onPressed: () async {
                  if (validate()) {
                    int storeId = await AuthService().getStoreId();
                    String extData = "png";
                    String fileExtension = selectedImage!.path
                        .substring(selectedImage!.path.lastIndexOf('.') + 1)
                        .toLowerCase();
                    if (fileExtension != "png") {
                      extData = "jpeg";
                    }

                    context.read<ItemBloc>().add(
                          ItemPost(
                            ItemFormModel(
                              name: nameController.text,
                              categoryId: _selectedCategory,
                              storeId: storeId,
                              stock: int.parse(stockController.text),
                              basePrice: int.parse(basePriceController.text),
                              detail: detailController.text,
                              sourceImage: 'data:image/$extData;base64,' +
                                  base64Encode(
                                    File(selectedImage!.path).readAsBytesSync(),
                                  ),
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
