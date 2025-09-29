import 'package:bloc/bloc.dart';
import 'package:car_rent/data/data_sorse/remote/car/car_data.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final CarData carData;
  List<CarModel> cars = [];

  CarsCubit(this.carData) : super(CarsInitial());

  Future<void> fetchCars() async {
    emit(CarLoading());
    try {
      final response = await carData.gaetAllCar(); // تأكد من اسم الميثود
      response.fold((failure) => emit(CarError(failure.toString())), (data) {
        cars = List<CarModel>.from(
          (data as List).map((car) => CarModel.fromJson(car)),
        );
        emit(CarLoaded(cars: cars));
      });
    } catch (e) {
      emit(CarError(e.toString()));
    }
  }
}
