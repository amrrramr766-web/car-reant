import 'package:car_rent/controller/auth/login/cubit/login_cubit.dart';
import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/data/data_sorse/remote/auth/login.dart';
import 'package:car_rent/data/model/login_requst.dart';
import 'package:car_rent/l10n/app_localizations.dart';
import 'package:car_rent/view/pages/auth/regster.dart';
import 'package:car_rent/view/pages/home/home.dart';
import 'package:car_rent/view/widget/auth/auth_app_bar.dart';
import 'package:car_rent/view/widget/auth/widge_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _goToHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => Home()),
        (route) => false,
      );
    }

    final t = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => LoginCubit(LoginData(Crud())),
      child: Scaffold(
        appBar: AuthAppBar(title: t?.login ?? 'Login'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                CircularProgressIndicator();
              }
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.name)));
                _goToHome();
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              return state is LoginLoading
                  ? Center(child: const CircularProgressIndicator())
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: t?.email ?? "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: t?.password ?? "Password",
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t?.dontHaveAccount ?? "Don't have an account? ",
                              ),
                              GestureDetector(
                                onTap: () => _goToRegister(context),
                                child: Text(
                                  t?.register ?? "Register",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          WidgeButton(
                            onPressed: () {
                              context.read<LoginCubit>().login(
                                LoginRequst(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            },
                            text: t?.login ?? 'Login',
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
