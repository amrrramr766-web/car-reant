import 'package:car_rent/core/constant/app_route.dart';
import 'package:car_rent/core/middleware/cubit/middlewaer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MiddlewaerCubit()..checkStep(),
      child: BlocListener<MiddlewaerCubit, MiddlewaerState>(
        listener: (context, state) {
          if (state is AppGoHome) {
            Navigator.pushReplacementNamed(context, AppRoute.home);
          } else if (state is AppGoLogin) {
            Navigator.pushReplacementNamed(context, AppRoute.login);
          } else if (state is AppGoOnBoarding) {
            Navigator.pushReplacementNamed(context, AppRoute.onBoarding);
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
