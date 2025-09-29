import 'package:bloc/bloc.dart';
import 'package:car_rent/data/data_sorse/remote/home/home.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeData homeData;
  HomeCubit(this.homeData) : super(HomeInitial());
  List<CarModel> cars = [];

  Future<void> fetchCars() async {
    emit(HomeLoading());
    try {
      final response = await homeData.getData();
      //   print('Response from HomeCubit: ${response.toString()}');
      response.fold((failure) => emit(HomeError(failure.toString())), (data) {
        // هنا data هي List<dynamic> مباشرة
        cars = List<CarModel>.from(
          (data as List).map((car) => CarModel.fromJson(car)),
        );

        List<CarModel> carsByBrand = cars
            .where((car) => car.brand == 'Toyota')
            .toList();

        List<String> brands = cars.map((car) => car.brand).toSet().toList();
        List<String> categories = ['SUV', 'Sedan', 'Hatchback', 'Convertible'];

        emit(
          HomeLoaded(
            cars: cars,
            carsByBrand: carsByBrand,
            brands: brands,
            categories: categories,
          ),
        );
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
