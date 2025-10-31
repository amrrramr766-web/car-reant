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
  final List<OfferModel> offers;
  const HomeLoaded({
    required this.cars,
    required this.brands,
    required this.categories,
    required this.carsByBrand,
    required this.offers,
  });
  @override
  List<Object?> get props => [cars, brands, categories, carsByBrand, offers];
}

final class HomeError extends HomeState {
  final String errorMessage;

  const HomeError(this.errorMessage);
}
