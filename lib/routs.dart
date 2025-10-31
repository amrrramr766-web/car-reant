import 'package:car_rent/controller/cars/cubit/cars_cubit.dart';
import 'package:car_rent/core/constant/app_route.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/server_locator.dart';
import 'package:car_rent/view/pages/CarDetale/car_detail.dart';
import 'package:car_rent/view/pages/auth/login.dart';
import 'package:car_rent/view/pages/auth/regster.dart';
import 'package:car_rent/view/pages/cars/brawes_cars.dart';
import 'package:car_rent/view/pages/home/home.dart';
import 'package:car_rent/view/pages/onBording/on_bording_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.login: (context) => LoginScreen(),
  AppRoute.register: (context) => RegisterScreen(),
  AppRoute.onBoarding: (context) {
    return OnBordingScreen(); // pass translation here
  },
  AppRoute.carDetail: (context) {
    return CarDetailsPage(
      car: ModalRoute.of(context)!.settings.arguments as CarModel,
    );
  },
  AppRoute.brawesCars: (context) => BlocProvider(
    create: (_) => sl<CarsCubit>()..fetchCars(),
    child: const BrowseCars(),
  ),

  AppRoute.home: (context) => const Home(),
};
