import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_pos/models/transaction_form_model.dart';
import 'package:simple_pos/models/transaction_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_values.dart';

class TransactionService {
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final token = await AuthService().getToken();
      final userId = await AuthService().getUserId();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/api/v1/transaction/$userId',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TransactionModel>.from(
          jsonDecode(res.body)['data'].map(
            (orderMethod) => TransactionModel.formJson(orderMethod),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTransaction(TransactionFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/api/v1/transaction',
        ),
        headers: {
          'Authorization': token,
        },
        body: jsonEncode(data.toJson()),
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['error'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
