import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/core/class/states_request.dart';
import 'package:car_rent/link_api.dart';
import 'package:dartz/dartz.dart';

class ReviweData {
  Crud crud;
  ReviweData(this.crud);

  Future<Either<StatusRequest, dynamic>> getData(int carId) async {
    return await crud.getData("${LinkApi.getReviweByCarId}$carId");
  }
}
