import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/order_method/order_method_bloc.dart';
import 'package:simple_pos/models/order_method_form_model.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/forms.dart';

class OrderMethodForm extends StatefulWidget {
  const OrderMethodForm({super.key});

  @override
  State<OrderMethodForm> createState() => _OrderMethodFormState();
}

class _OrderMethodFormState extends State<OrderMethodForm> {
  final nameController = TextEditingController(text: '');
  final markOrderController = TextEditingController(text: '');
  final priceController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        markOrderController.text.isEmpty ||
        priceController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderMethodBloc(),
      child: BlocConsumer<OrderMethodBloc, OrderMethodState>(
        listener: (context, state) {
          if (state is OrderMethodPostSuccess) {
            showSuccessSnackbar(
              context,
              'Order method has been added!',
            );
            setState(() {
              nameController.text = '';
              markOrderController.text = '';
              priceController.text = '';
            });
          }

          if (state is OrderMethodFailed) {
            showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is OrderMethodLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Order Method Form"),
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
              title: const Text("Order Method Form"),
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
                    borderRadius: BorderRadius.circular(20),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        title: "Name",
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        title: "Mark Order",
                        controller: markOrderController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        title: "Price",
                        keyboardType: TextInputType.number,
                        controller: priceController,
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
                onPressed: () {
                  if (validate()) {
                    context.read<OrderMethodBloc>().add(
                          OrderMethodPost(
                            OrderMethodFormModel(
                              name: nameController.text,
                              markOrder: markOrderController.text,
                              price: int.parse(priceController.text),
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
