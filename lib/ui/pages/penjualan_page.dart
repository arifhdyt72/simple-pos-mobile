import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/blocs/transaction/transaction_bloc.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/transaction_item.dart';

class PenjualanPage extends StatelessWidget {
  const PenjualanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc()..add(TransactionGet()),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: ListView(
          children: [
            Text(
              "Transaction Data",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TransactionSuccess) {
                  return Column(
                    children: state.transactions.map((transaction) {
                      return TransactionItem(
                        transaction: transaction,
                      );
                    }).toList(),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
