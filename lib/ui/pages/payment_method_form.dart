import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/payment_method/payment_method_bloc.dart';
import 'package:simple_pos/models/payment_method_form_model.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/forms.dart';

class PaymentMethodForm extends StatefulWidget {
  const PaymentMethodForm({super.key});

  @override
  State<PaymentMethodForm> createState() => _PaymentMethodFormState();
}

class _PaymentMethodFormState extends State<PaymentMethodForm> {
  final nameController = TextEditingController(text: '');
  bool validate() {
    if (nameController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentMethodBloc(),
      child: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
        listener: (context, state) {
          if (state is PaymentMethodPostSuccess) {
            showSuccessSnackbar(
              context,
              'Payment method has been added!',
            );
            setState(() {
              nameController.text = '';
            });
          }

          if (state is PaymentMethodFailed) {
            showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is PaymentMethodLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Payment Method Form"),
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
              title: const Text("Payment Method Form"),
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
                    context.read<PaymentMethodBloc>().add(
                          PaymentMethodPost(
                            PaymentMethodFormModel(
                              name: nameController.text,
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
