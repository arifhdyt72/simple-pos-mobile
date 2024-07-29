import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:simple_pos/models/item_cart_model.dart';
import 'package:simple_pos/models/item_form_model.dart';
import 'package:simple_pos/models/item_model.dart';
import 'package:simple_pos/models/item_search_model.dart';
import 'package:simple_pos/services/auth_service.dart';
import 'package:simple_pos/shared/shared_values.dart';

class ItemService {
  Future<List<ItemModel>> getAllItem(ItemSearchModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/api/v1/menu',
        ),
        headers: {
          'Authorization': token,
        },
        body: jsonEncode(data.toJson()),
      );

      if (res.statusCode == 200) {
        return List<ItemModel>.from(
          jsonDecode(res.body)['data'].map(
            (item) => ItemModel.formJson(item),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createItem(ItemFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrl/master/item',
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

  Future<void> addToCart(ItemCartModel product) async {
    const storage = FlutterSecureStorage();

    List<ItemCartModel> cart = await getCart();
    bool productExists = false;

    for (ItemCartModel p in cart) {
      if (p.id == product.id) {
        productExists = true;
        break;
      }
    }

    if (!productExists) {
      cart.add(product);
    }

    String cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
    await storage.write(key: 'cart', value: cartJson);
  }

  Future<void> updateProductQuantity(int itemId, int quantity) async {
    const storage = FlutterSecureStorage();
    List<ItemCartModel> cart = await getCart();

    for (ItemCartModel p in cart) {
      if (p.id == itemId) {
        p.qty = quantity;
        break;
      }
    }

    String cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
    await storage.write(key: 'cart', value: cartJson);
  }

  Future<void> reduceProductQuantity(int itemId, int quantity) async {
    const storage = FlutterSecureStorage();
    List<ItemCartModel> cart = await getCart();

    for (ItemCartModel p in cart) {
      if (p.id == itemId) {
        p.qty -= quantity;
        if (p.qty <= 0) {
          cart.remove(p);
        }
        break;
      }
    }

    String cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
    await storage.write(key: 'cart', value: cartJson);
  }

  Future<List<ItemCartModel>> getCart() async {
    const storage = FlutterSecureStorage();
    String? cartJson = await storage.read(key: 'cart');
    if (cartJson != null) {
      List<dynamic> cartList = jsonDecode(cartJson);
      return cartList.map((item) => ItemCartModel.formJson(item)).toList();
    }
    return [];
  }

  Future<void> deleleAllCart() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'cart');
  }
}
