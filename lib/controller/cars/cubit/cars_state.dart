part of 'cars_cubit.dart';

@immutable
sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object?> get props => [];
}

final class CarsInitial extends CarsState {}

final class CarLoading extends CarsState {}

final class CarLoaded extends CarsState {
  final List<CarModel> cars;

  const CarLoaded({required this.cars});

  @override
  List<Object?> get props => [cars];
}

final class CarError extends CarsState {
  final String errorMessage;

  const CarError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
