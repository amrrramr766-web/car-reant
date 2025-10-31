import 'package:car_rent/controller/home/cubit/home_cubit.dart';
import 'package:car_rent/controller/search/cubit/search_cubit.dart';
import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/data/data_sorse/remote/search_data.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/data/model/offer_model.dart';
import 'package:car_rent/view/widget/home/car_list.dart';
import 'package:car_rent/view/widget/home/custom_app_bar.dart';
import 'package:car_rent/view/widget/home/offer_banner.dart';
import 'package:car_rent/view/widget/home/serch.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    context.read<HomeCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(SearchData(Crud())),
      child: Scaffold(
        appBar: const CustomAppBar(),

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  final searchCubit = context.read<SearchCubit>();
                  showSearch(
                    context: context,
                    delegate: Search(searchCubit: searchCubit),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Search Cars",
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_online),
                  label: "Bookings",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
              ],
            ),
          ],
        ),

        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
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

            final offerModels = state is HomeLoaded
                ? state.offers
                      .map(
                        (offer) => OfferModel(
                          id: offer.id,
                          imageUrl: offer.imageUrl,
                          description: offer.description,
                          persenteg: offer.persenteg,
                          endDate: offer.endDate,
                        ),
                      )
                      .toList()
                : <OfferModel>[];

            final popularCars = state is HomeLoaded
                ? state.cars.cast<CarModel>()
                : <CarModel>[];

            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().loadHomeData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    if (offerModels.isNotEmpty)
                      OfferBanner(
                        offers: offerModels,
                        pageController: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),

                    if (offerModels.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: DotsIndicator(
                          dotsCount: offerModels.length,
                          position: _currentIndex.toDouble(),
                          decorator: DotsDecorator(
                            size: const Size.square(8.0),
                            activeSize: const Size(18.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    CarList(
                      pageController: _pageController,
                      currentIndex: _currentIndex,
                      cars: popularCars,
                      title: 'Popular Cars',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
