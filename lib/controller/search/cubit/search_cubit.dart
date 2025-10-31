import 'dart:developer' as developer;

import 'package:car_rent/core/class/states_request.dart';
import 'package:car_rent/data/data_sorse/remote/search_data.dart';
import 'package:car_rent/data/model/suggestions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_state.dart';
import 'package:car_rent/data/model/car_model.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchData searchData;
  int _requestCounter = 0;
  int _lastHandledRequestId = 0;

  SearchCubit(this.searchData) : super(SearchInitial());

  Future<void> searchSuggestions(String query) async {
    // assign and log a request id to help debug out-of-order responses
    _requestCounter++;
    final int requestId = _requestCounter;
    developer.log(
      'searchSuggestions START id=$requestId query="$query"',
      name: 'SearchCubit',
    );

    emit(SearchLoading());

    Either<StatusRequest, dynamic> result;

    try {
      if (query.isEmpty) {
        // Get default suggestions
        result = await searchData.getSuggestions();
      } else {
        // Search with query
        result = await searchData.search(query);
      }

      // If a newer request was started, ignore this (prevents showing stale results)
      if (requestId < _requestCounter) {
        developer.log(
          'searchSuggestions IGNORE id=$requestId newer id=${_requestCounter}',
          name: 'SearchCubit',
        );
        return;
      }

      _lastHandledRequestId = requestId;

      result.fold(
        (l) {
          developer.log(
            'searchSuggestions ERROR id=$requestId status=$l',
            name: 'SearchCubit',
          );
          emit(const SearchError("Failed to search"));
        },
        (r) {
          developer.log(
            'searchSuggestions RESULT id=$requestId raw=${r.runtimeType}',
            name: 'SearchCubit',
          );
          if (r == null || (r as List).isEmpty) {
            emit(SearchNoResults());
          } else {
            final suggestions = (r as List)
                .map((e) => SuggestionsModel.fromJson(e))
                .toList();
            emit(SearchResults(suggestions: suggestions));
          }
        },
      );
    } catch (e, st) {
      developer.log(
        'searchSuggestions EXCEPTION id=$requestId error=$e',
        error: e,
        stackTrace: st,
        name: 'SearchCubit',
      );
      emit(const SearchError("Failed to search"));
    }
  }

  Future<CarModel?> getCarDetails(int carId) async {
    // Use request id to trace car detail fetch
    _requestCounter++;
    final int requestId = _requestCounter;
    developer.log(
      'getCarDetails START id=$requestId carId=$carId',
      name: 'SearchCubit',
    );

    emit(SearchLoading());
    final result = await searchData.getCarById(carId);

    try {
      // ignore out-of-order here as well
      if (requestId < _requestCounter) {
        developer.log(
          'getCarDetails IGNORE id=$requestId newer id=${_requestCounter}',
          name: 'SearchCubit',
        );
        return null;
      }

      CarModel? car;
      result.fold(
        (l) {
          developer.log(
            'getCarDetails ERROR id=$requestId status=$l',
            name: 'SearchCubit',
          );
          emit(SearchError("Failed to fetch car details"));
        },
        (r) {
          developer.log(
            'getCarDetails RESULT id=$requestId raw=${r.runtimeType}',
            name: 'SearchCubit',
          );
          car = CarModel.fromJson(r);
        },
      );

      _lastHandledRequestId = requestId;
      return car;
    } catch (e, st) {
      developer.log(
        'getCarDetails EXCEPTION id=$requestId error=$e',
        error: e,
        stackTrace: st,
        name: 'SearchCubit',
      );
      emit(SearchError("Failed to fetch car details"));
      return null;
    }
  }
}
