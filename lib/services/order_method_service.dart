import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_pos/models/order_method_form_model.dart';
import 'package:simple_pos/models/order_method_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_values.dart';

class OrderMethodService {
  Future<List<OrderMethodModel>> getOrderMethod() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/api/v1/order_method',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<OrderMethodModel>.from(
          jsonDecode(res.body)['data'].map(
            (orderMethod) => OrderMethodModel.formJson(orderMethod),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createOrderMethod(OrderMethodFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/master/order_method',
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
