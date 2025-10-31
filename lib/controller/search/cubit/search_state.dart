import 'package:equatable/equatable.dart';
import 'package:car_rent/data/model/suggestions.dart';
import 'package:car_rent/data/model/car_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

// Initial state before search
class SearchInitial extends SearchState {}

// Loading state when search is in progress
class SearchLoading extends SearchState {}

// Results state for multiple suggestions
class SearchResults extends SearchState {
  final List<SuggestionsModel> suggestions;
  final List<CarModel> cars; // optional if search returns cars too

  const SearchResults({this.suggestions = const [], this.cars = const []});

  @override
  List<Object?> get props => [suggestions, cars];
}

// State for no results
class SearchNoResults extends SearchState {}

// Error state
class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
