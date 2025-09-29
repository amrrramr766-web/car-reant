import 'package:car_rent/controller/bookin_cubit/cubit/booking_cubit.dart';
import 'package:car_rent/view/pages/bookingPage/success_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmBookingButton extends StatelessWidget {
  final int totalDays;
  final int carId;
  final int userId;
  final double totalPrice;
  final DateTime startDate;
  final DateTime endDate;

  const ConfirmBookingButton({
    super.key,
    required this.totalDays,
    required this.carId,
    required this.userId,
    required this.totalPrice,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    if (totalDays == 0) return const SizedBox.shrink();

    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          // Navigate to success page on success
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SuccessBooking()),
            );
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is BookingFailure) {
          // Show error message
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is BookingLoading
                ? null
                : () {
                    context.read<BookingCubit>().makeBooking(
                      carId: carId,
                      userId: userId,
                      totalPrice: totalPrice,
                      startDate: startDate,
                      endDate: endDate,
                    );
                  },
            child: state is BookingLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text("Confirm Booking"),
          ),
        );
      },
    );
  }
}
