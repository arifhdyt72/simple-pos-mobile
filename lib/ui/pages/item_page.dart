// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/item/item_bloc.dart';
import 'package:simple_pos/models/item_cart_model.dart';
import 'package:simple_pos/models/item_search_model.dart';
import 'package:simple_pos/services/item_service.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/forms.dart';
import 'package:simple_pos/ui/widgets/item_widget.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final nameController = TextEditingController(text: '');

  late ItemBloc itemBloc;

  @override
  void initState() {
    super.initState();

    itemBloc = context.read<ItemBloc>()
      ..add(ItemGet(ItemSearchModel(name: nameController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: ListView(
        children: [
          CustomFormField(
            title: 'Search Item',
            isShowTitle: false,
            controller: nameController,
            onFieldSubmitted: (value) {
              itemBloc.add(ItemGet(ItemSearchModel(name: nameController.text)));
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              if (state is ItemLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ItemSuccess) {
                if (state.items.isEmpty) {
                  return Center(
                    child: Text(
                      "Item Empty",
                      style: greyTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: medium,
                      ),
                    ),
                  );
                } else {
                  return Wrap(
                    spacing: 17,
                    runSpacing: 18,
                    children: state.items.map((item) {
                      return ItemWidget(
                        item: item,
                        onTap: () async {
                          await ItemService().addToCart(ItemCartModel(
                            id: item.id,
                            name: item.name,
                            categoryId: item.categoryId,
                            storeId: item.storeId,
                            stock: item.stock,
                            basePrice: item.basePrice,
                            detail: item.detail,
                            photo: item.photo,
                            qty: 1,
                          ));

                          showSuccessSnackbar(
                            context,
                            "item has been add to cart",
                          );
                        },
                      );
                    }).toList(),
                  );
                }
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
