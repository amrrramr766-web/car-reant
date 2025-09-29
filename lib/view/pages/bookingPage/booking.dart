import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/view/widget/booking%20widget/car_info_card.dart';
import 'package:car_rent/view/widget/booking%20widget/confirm_booking-button.dart';
import 'package:car_rent/view/widget/booking%20widget/date_picker_section.dart';
import 'package:car_rent/view/widget/booking%20widget/price_details_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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

  void _onDateSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      tempStartDate = args.value.startDate;
      tempEndDate = args.value.endDate ?? args.value.startDate;
    }
  }

  void _confirmDateSelection() {
    if (tempStartDate != null && tempEndDate != null) {
      setState(() {
        startDate = tempStartDate;
        endDate = tempEndDate;
        totalDays = endDate!.difference(startDate!).inDays + 1;
        showPicker = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = totalDays * widget.car.pricePerDay;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Booking Page')),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CarInfoCard(car: widget.car),
                    const SizedBox(height: 20),
                    DatePickerSection(
                      showPicker: showPicker,
                      onToggle: () => setState(() => showPicker = !showPicker),
                      onSelectionChanged: _onDateSelectionChanged,
                      onConfirm: _confirmDateSelection,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  PriceDetailsCard(
                    startDate: startDate,
                    endDate: endDate,
                    pricePerDay: widget.car.pricePerDay,
                    totalPrice: totalPrice,
                  ),
                  const SizedBox(height: 12),
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
      ),
    );
  }
}
