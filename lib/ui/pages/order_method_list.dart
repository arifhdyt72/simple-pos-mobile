import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/order_method/order_method_bloc.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/order_method_item.dart';

class OrderMethodList extends StatelessWidget {
  const OrderMethodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Method"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderMethodBloc()..add(OrderMethodGet()),
        child: BlocConsumer<OrderMethodBloc, OrderMethodState>(
          listener: (context, state) {
            if (state is OrderMethodPostSuccess) {
              context.read<OrderMethodBloc>().add(OrderMethodGet());
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              children: [
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<OrderMethodBloc, OrderMethodState>(
                  builder: (context, state) {
                    if (state is OrderMethodSuccess) {
                      return Column(
                        children: state.orderMethods.map(
                          (orderMethod) {
                            return OrderMethodItem(
                              orderMethod: orderMethod,
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
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(24),
        child: CustomFilledButton(
          title: 'Add Data',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/order_method_form',
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
