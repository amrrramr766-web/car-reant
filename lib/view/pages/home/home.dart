import 'package:car_rent/controller/home/cubit/home_cubit.dart';
import 'package:car_rent/data/data_sorse/local%20data/onBoardingModel.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/view/widget/home/car_list.dart';
import 'package:car_rent/view/widget/home/custom_app_bar.dart';
import 'package:car_rent/view/widget/home/dots_Indicator.dart';
import 'package:car_rent/view/widget/home/home_carousel.dart';
import 'package:dartz/dartz.dart' as cars;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    final items = onBoardingList(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            // نضمن إن Scaffold مبني أولاً
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            });
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          state is HomeLoaded ? state.carsByBrand : [];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeCarousel(
                    items: items,
                    pageController: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DotsIndicator(
                    dotsCount: items.length,
                    position: _currentIndex.toDouble(),
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CarList(
                    pageController: _pageController,
                    currentIndex: _currentIndex,
                    cars: state is HomeLoaded
                        ? (state.cars as List<CarModel>)
                        : [],
                    title: 'Popular Cars',
                  ),
                  const SizedBox(height: 12),
                  CarList(
                    pageController: _pageController,
                    currentIndex: _currentIndex,
                    cars: state is HomeLoaded ? state.carsByBrand : [],
                    title: 'Toyota Cars',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
