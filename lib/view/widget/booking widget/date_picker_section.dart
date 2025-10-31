import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingBottomSheet extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime, DateTime) onConfirm;

  BookingBottomSheet({
    required this.startDate,
    required this.endDate,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? tempStart = startDate;
    DateTime? tempEnd = endDate;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            minDate: DateTime.now(),
            initialSelectedRange: startDate != null && endDate != null
                ? PickerDateRange(startDate, endDate)
                : null,
            onSelectionChanged: (args) {
              if (args.value is PickerDateRange) {
                tempStart = args.value.startDate;
                tempEnd = args.value.endDate ?? args.value.startDate;
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (tempStart != null && tempEnd != null) {
                onConfirm(tempStart!, tempEnd!);
              }
            },
            child: Text("تأكيد"),
          ),
        ],
      ),
    );
  }
}
