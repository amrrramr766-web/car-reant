import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/view/widget/booking%20widget/car_info_card.dart';
import 'package:car_rent/view/widget/booking%20widget/confirm_booking-button.dart';
import 'package:car_rent/view/widget/booking%20widget/date_picker_section.dart';
import 'package:car_rent/view/widget/booking%20widget/price_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking extends StatefulWidget {
  final CarModel car;
  const Booking({super.key, required this.car});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? startDate;
  DateTime? endDate;
  int totalDays = 0;
  bool showPicker = false;
  DateTime? tempStartDate;
  DateTime? tempEndDate;

  int? userId; // <- Add this

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt("userID") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = totalDays * widget.car.pricePerDay;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0.w),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CarInfoCard(car: widget.car),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return BookingBottomSheet(
                              startDate: startDate,
                              endDate: endDate,
                              onConfirm: (start, end) {
                                setState(() {
                                  startDate = start;
                                  endDate = end;
                                  totalDays =
                                      endDate!.difference(startDate!).inDays +
                                      1;
                                });
                                Navigator.pop(
                                  context,
                                ); // لإغلاق الـ Bottom Sheet
                              },
                            );
                          },
                        );
                      },
                      child: Text("اختر التواريخ"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              children: [
                PriceDetailsCard(
                  startDate: startDate,
                  endDate: endDate,
                  pricePerDay: widget.car.pricePerDay,
                  totalPrice: totalPrice,
                ),
                SizedBox(height: 12.h),
                ConfirmBookingButton(
                  totalDays: totalDays,
                  carId: widget.car.carId,
                  userId: userId ?? 0, // <- Pass the loaded user ID
                  startDate: startDate ?? DateTime.now(),
                  endDate: endDate ?? DateTime.now(),
                  totalPrice: totalPrice,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
