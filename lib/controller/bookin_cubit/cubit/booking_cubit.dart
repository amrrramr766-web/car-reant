import 'package:bloc/bloc.dart';
import 'package:car_rent/data/data_sorse/remote/booking/booking_data.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:car_rent/core/class/states_request.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingData bookingData;
  BookingCubit(this.bookingData) : super(BookingInitial());

  Future<void> makeBooking({
    required int carId,
    required int userId,
    required double totalPrice,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(BookingLoading());
    try {
      // Default status as 'pending'
      final Either<StatusRequest, int> response = await bookingData.addBooking(
        userId: userId,
        carID: carId,
        totalPrice: totalPrice,
        startDate: startDate,
        endDate: endDate,
      );

      response.fold(
        (failure) => emit(BookingFailure(failure.toString())),
        (bookingId) =>
            emit(BookingSuccess("Booking successful! ID: $bookingId")),
      );
    } catch (e) {
      emit(BookingFailure(e.toString()));
    }
  }

  // Cubit لا يجب أن يعرف تفاصيل SQL مباشرة
  // استعمل BookingData أو أي service لجلب البيانات
  Future<void> fetchUserBookings(int userId) async {
    emit(BookingLoading());
    try {
      final Either<StatusRequest, List<dynamic>> response = await bookingData
          .getBookingsByUserId(userId);

      response.fold(
        (failure) => emit(BookingFailure(failure.toString())),
        (bookings) => emit(BookingLoaded(bookings)),
      );
    } catch (e) {
      emit(BookingFailure("Failed to load bookings: $e"));
    }
  }
}
