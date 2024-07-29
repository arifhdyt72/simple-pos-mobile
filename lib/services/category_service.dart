import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_pos/models/category_form_model.dart';
import 'package:simple_pos/models/category_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_values.dart';

class CategoryService {
  Future<List<CategoryModel>> getLimitCategory() async {
    try {
      final token = await AuthService().getToken();
      final storeId = await AuthService().getStoreId();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/api/v1/category_limit/$storeId',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<CategoryModel>.from(
          jsonDecode(res.body)['data'].map(
            (category) => CategoryModel.formJson(category),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final token = await AuthService().getToken();
      final storeId = await AuthService().getStoreId();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/api/v1/category/$storeId',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<CategoryModel>.from(
          jsonDecode(res.body)['data'].map(
            (category) => CategoryModel.formJson(category),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createCategory(CategoryFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/master/category',
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
