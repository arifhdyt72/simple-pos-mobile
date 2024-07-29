import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/payment_method/payment_method_bloc.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/payment_method_item.dart';

class PaymentMethodList extends StatelessWidget {
  const PaymentMethodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => PaymentMethodBloc()..add(PaymentMethodGet()),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodSuccess) {
                  return Column(
                    children: state.paymentMethods.map(
                      (paymentMethod) {
                        return PaymentMethodItem(
                          paymentMethod: paymentMethod,
                        );
                      },
                    ).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(24),
        child: CustomFilledButton(
          title: 'Add Data',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/payment_method_form',
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
