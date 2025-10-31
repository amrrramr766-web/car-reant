import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/core/class/states_request.dart';
import 'package:car_rent/link_api.dart';
import 'package:dartz/dartz.dart';

class SearchData {
  Crud crud;
  SearchData(this.crud);

  Future<Either<StatusRequest, dynamic>> getCarById(int id) async {
    print('[SearchData] getCarById START id=$id -> ${LinkApi.getCarById}/$id');
    final response = await crud.getData('${LinkApi.getCarById}/$id');
    print('[SearchData] getCarById RESULT id=$id -> $response');
    return response;
  }

  Future<Either<StatusRequest, dynamic>> getSuggestions() async {
    print('[SearchData] getSuggestions START -> ${LinkApi.getSuggestions}');
    final response = await crud.getData(LinkApi.getSuggestions);
    print('[SearchData] getSuggestions RESULT -> $response');
    return response;
  }

  Future<Either<StatusRequest, dynamic>> search(String query) async {
    print('[SearchData] search START query="$query" -> ${LinkApi.Search}');
    final response = await crud.getData('${LinkApi.Search}?query=$query');
    print('[SearchData] search RESULT query="$query" -> $response');
    return response;
  }
}
