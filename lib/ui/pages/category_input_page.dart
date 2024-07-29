// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_pos/blocs/category/category_bloc.dart';
import 'package:simple_pos/models/category_form_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/forms.dart';

class CategoryInputPage extends StatefulWidget {
  const CategoryInputPage({super.key});

  @override
  State<CategoryInputPage> createState() => _CategoryInputPageState();
}

class _CategoryInputPageState extends State<CategoryInputPage> {
  final categoryController = TextEditingController(text: '');
  XFile? selectedImage;

  bool validate() {
    if (categoryController.text.isEmpty && selectedImage == null) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryPostSuccess) {
            showSuccessSnackbar(
              context,
              'Category has been added!',
            );

            setState(() {
              selectedImage = null;
              categoryController.text = '';
            });
          }

          if (state is CategoryFailed) {
            showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Form Category"),
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
              title: const Text("Form Category"),
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
                  padding: const EdgeInsets.all(
                    24,
                  ),
                  margin: const EdgeInsets.only(
                    top: 30,
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
                        title: 'Category Name',
                        controller: categoryController,
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

                    context.read<CategoryBloc>().add(
                          CategoryPost(
                            CategoryFormModel(
                              name: categoryController.text,
                              storeId: storeId,
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
