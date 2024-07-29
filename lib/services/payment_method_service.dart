import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_pos/models/payment_method_form_model.dart';
import 'package:simple_pos/models/payment_method_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_values.dart';

class PaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMethod() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/api/v1/payment_method',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<PaymentMethodModel>.from(
          jsonDecode(res.body)['data'].map(
            (orderMethod) => PaymentMethodModel.formJson(orderMethod),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createPaymentMethod(PaymentMethodFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/master/payment_method',
        ),
        headers: {
          'Authorization': token,
        },
        body: jsonEncode(data.toJson()),
      );
      if (res.statusCode != 202) {
        if (jsonDecode(res.body)['error'] == null) {
          throw jsonDecode(res.body)['error_db'];
        } else {
          throw jsonDecode(res.body)['error'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
