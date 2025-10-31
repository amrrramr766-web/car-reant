part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingSuccess extends BookingState {
  final String message;
  BookingSuccess(this.message);
}

class BookingLoaded extends BookingState {
  final List<dynamic> bookings; // أو BookingDTO
  BookingLoaded(this.bookings);
}

final class BookingFailure extends BookingState {
  final String error;
  BookingFailure(this.error);
}
