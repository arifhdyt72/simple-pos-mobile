import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:simple_pos/models/login_form_model.dart';
import 'package:simple_pos/models/user_model.dart';
import 'package:simple_pos/shared/shared_values.dart';

class AuthService {
  Future<UserModel> login(LoginFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/api/v1/auth',
        ),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.formJson(jsonDecode(res.body)['user']);
        String tokenData = jsonDecode(res.body)['token'];
        user = user.copyWith(password: data.password, token: tokenData);

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['error'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await clearStorage();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'user_id', value: user.id.toString());
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'name', value: user.name);
      await storage.write(key: 'username', value: user.username);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'store_id', value: user.storeId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();
      if (values['username'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final LoginFormModel data = LoginFormModel(
          username: values['username'],
          password: values['password'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    if (value != null) {
      token = value;
    }

    return 'Bearer $token';
  }

  Future<void> clearStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<int> getStoreId() async {
    int storeId = 0;

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'store_id');
    if (value != null) {
      storeId = int.parse(value);
    }

    return storeId;
  }

  Future<int> getUserId() async {
    int userId = 0;

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'user_id');
    if (value != null) {
      userId = int.parse(value);
    }

    return userId;
  }
}
