part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List cars;
  final List brands;
  final List categories;
  final List<CarModel> carsByBrand;

  HomeLoaded({
    required this.cars,
    required this.brands,
    required this.categories,
    required this.carsByBrand,
  });
  @override
  List<Object?> get props => [cars, brands, categories, carsByBrand];
}

final class HomeError extends HomeState {
  final String errorMessage;

  HomeError(this.errorMessage);
}
