import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/core/class/states_request.dart';
import 'package:car_rent/link_api.dart';
import 'package:dartz/dartz.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);
  Future<Either<StatusRequest, dynamic>> getData() async {
    return await crud.getData(LinkApi.getCars);
  }
}
