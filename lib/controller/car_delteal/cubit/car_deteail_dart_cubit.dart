import 'package:bloc/bloc.dart';
import 'package:car_rent/data/data_sorse/remote/reviwe/reviwe.dart';
import 'package:car_rent/data/model/reviwe_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'car_deteail_dart_state.dart';

class CarDeteailDartCubit extends Cubit<CarDeteailDartState> {
  final ReviweData reviwe;
  CarDeteailDartCubit(this.reviwe) : super(CarDeteailDartInitial());

  List<ReviewModel> reviews = [];

  Future<void> fetchReviews(int carId) async {
    emit(CarDeteailDartLoading());
    try {
      final response = await reviwe.getData(carId);

      response.fold(
        (status) {
          // هنا نتحقق إذا كان status يشير لفشل الاتصال أو خطأ آخر
          emit(CarDeteailDartError("حدث خطأ في الاتصال: ${status.toString()}"));
        },
        (data) {
          List<ReviewModel> loadedReviews = [];
          if (data is List && data.isNotEmpty) {
            loadedReviews = data
                .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }
          // حتى لو كانت القائمة فارغة، لا يعتبر خطأ
          emit(CarDeteailDartLoaded(loadedReviews));
        },
      );
    } catch (e) {
      // أي استثناء غير متوقع
      emit(CarDeteailDartError("حدث خطأ غير متوقع: $e"));
    }
  }
}
