import 'package:bloc/bloc.dart';
import 'package:car_rent/data/data_sorse/remote/home/home.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/data/model/offer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeData homeData;
  HomeCubit(this.homeData) : super(HomeInitial());

  List<CarModel> cars = [];
  List<String> brands = [];
  List<String> categories = ['SUV', 'Sedan', 'Hatchback', 'Convertible'];
  List<CarModel> carsByBrand = [];
  List<OfferModel> offers = [];

  Future<void> fetchCars() async {
    emit(HomeLoading());
    try {
      final response = await homeData.getData();

      response.fold((failure) => emit(HomeError(failure.toString())), (data) {
        cars = List<CarModel>.from(
          (data as List).map((car) => CarModel.fromJson(car)),
        );

        carsByBrand = cars.where((car) => car.brand == 'Toyota').toList();
        brands = cars.map((car) => car.brand).toSet().toList();

        emit(
          HomeLoaded(
            cars: cars,
            carsByBrand: carsByBrand,
            brands: brands,
            categories: categories,
            offers: offers, // ✅ Initially empty
          ),
        );
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    await fetchCars();
    await getOffers();
  }

  Future<void> getOffers() async {
    // Debug: Uncomment for troubleshooting
    // print('getOffers() called');
    try {
      final response = await homeData.getOffers();
      // Debug: Uncomment for troubleshooting
      // print('Response received: $response');

      response.fold(
        (failure) {
          // Debug: Uncomment for troubleshooting
          // print('Failed to fetch offers: $failure');
          emit(HomeError(failure.toString()));
        },
        (data) {
          // Debug: Uncomment for troubleshooting
          // print('Data received: $data');
          offers = List<OfferModel>.from(
            (data as List).map((offer) {
              // Debug: Uncomment for troubleshooting
              // print('Mapping offer: $offer');
              return OfferModel.fromJson(offer);
            }),
          );

          // Debug: Uncomment for troubleshooting
          // print('Offers list: $offers');

          emit(
            HomeLoaded(
              cars: cars,
              carsByBrand: carsByBrand,
              brands: brands,
              categories: categories,
              offers: offers,
            ),
          );
        },
      );
    } catch (e) {
      // Debug: Uncomment for troubleshooting
      // print('Exception in getOffers: $e');
      emit(HomeError(e.toString()));
    }
  }
}
