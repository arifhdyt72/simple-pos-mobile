import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_pos/blocs/auth/auth_bloc.dart';
import 'package:simple_pos/blocs/item/item_bloc.dart';
import 'package:simple_pos/blocs/order_method/order_method_bloc.dart';
import 'package:simple_pos/blocs/payment_method/payment_method_bloc.dart';
import 'package:simple_pos/providers/page_provider.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/pages/cart_page.dart';
import 'package:simple_pos/ui/pages/category_all_page.dart';
import 'package:simple_pos/ui/pages/category_input_page.dart';
import 'package:simple_pos/ui/pages/item_input_page.dart';
import 'package:simple_pos/ui/pages/login_page.dart';
import 'package:simple_pos/ui/pages/main_page.dart';
import 'package:simple_pos/ui/pages/order_method_form.dart';
import 'package:simple_pos/ui/pages/order_method_list.dart';
import 'package:simple_pos/ui/pages/payment_method_form.dart';
import 'package:simple_pos/ui/pages/payment_method_list.dart';
import 'package:simple_pos/ui/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        BlocProvider(
          create: (context) => ItemBloc(),
        ),
        BlocProvider(
          create: (context) => OrderMethodBloc(),
        ),
        BlocProvider(
          create: (context) => PaymentMethodBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroudColor,
          appBarTheme: AppBarTheme(
            backgroundColor: lightBackgroudColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: blackColor,
            ),
            titleTextStyle: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ),
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const MainPage(),
          '/category_form': (context) => const CategoryInputPage(),
          '/category': (context) => const CategoryAllPage(),
          '/order_method': (context) => const OrderMethodList(),
          '/order_method_form': (context) => const OrderMethodForm(),
          '/payment_method': (context) => const PaymentMethodList(),
          '/payment_method_form': (context) => const PaymentMethodForm(),
          '/item_form': (context) => const ItemInputPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
