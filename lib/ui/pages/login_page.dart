import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_pos/blocs/auth/auth_bloc.dart';
import 'package:simple_pos/models/login_form_model.dart';
import 'package:simple_pos/providers/page_provider.dart';
import 'package:simple_pos/shared/shared_methods.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/widgets/buttons.dart';
import 'package:simple_pos/ui/widgets/forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }
          if (state is AuthSuccess) {
            Provider.of<PageProvider>(context, listen: false).resetIndex();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 100,
                  bottom: 50,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/store.png",
                      width: 100,
                    ),
                    Text(
                      "Simple POS Apps",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Sign In &\nGrow Your Sale',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      title: 'Username',
                      controller: usernameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // NOTE: Password Input
                    CustomFormField(
                      title: 'Password',
                      obsecureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: 'Sign In',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  LoginFormModel(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                        } else {
                          showCustomSnackbar(
                            context,
                            'Semua field harus diisi',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
