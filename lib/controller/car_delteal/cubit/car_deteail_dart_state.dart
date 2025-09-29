part of 'car_deteail_dart_cubit.dart';

@immutable
sealed class CarDeteailDartState extends Equatable {
  CarDeteailDartState();
  @override
  List<Object?> get props => [];
}

final class CarDeteailDartInitial extends CarDeteailDartState {}

final class CarDeteailDartLoading extends CarDeteailDartState {}

final class CarDeteailDartLoaded extends CarDeteailDartState {
  final List<ReviewModel> reviews;
  CarDeteailDartLoaded(this.reviews);
}

final class CarDeteailDartError extends CarDeteailDartState {
  final String message;
  CarDeteailDartError(this.message);
}
