import 'package:car_rent/controller/bookin_cubit/cubit/booking_cubit.dart';
import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';
import 'package:car_rent/controller/cars/cubit/cars_cubit.dart';
import 'package:car_rent/data/data_sorse/remote/booking/booking_data.dart';
import 'package:car_rent/data/data_sorse/remote/car/car_data.dart';
import 'package:car_rent/data/data_sorse/remote/reviwe/reviwe.dart';
import 'package:get_it/get_it.dart';
import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/data/data_sorse/remote/home/home.dart';
import 'package:car_rent/controller/home/cubit/home_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerLazySingleton<Crud>(() => Crud());

  // Data sources
  sl.registerLazySingleton<HomeData>(() => HomeData(sl()));
  sl.registerLazySingleton<ReviweData>(() => ReviweData(sl()));
  sl.registerLazySingleton<BookingData>(() => BookingData(sl()));
  sl.registerLazySingleton<CarData>(() => CarData(sl()));

  // Cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
  sl.registerFactory<CarsCubit>(() => CarsCubit(sl()));
  sl.registerFactory<CarDeteailDartCubit>(
    () => CarDeteailDartCubit(sl<ReviweData>()),
  );
  sl.registerFactory<BookingCubit>(() => BookingCubit(sl<BookingData>()));
}
