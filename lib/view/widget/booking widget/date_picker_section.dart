import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerSection extends StatelessWidget {
  final bool showPicker;
  final VoidCallback onToggle;
  final ValueChanged<DateRangePickerSelectionChangedArgs> onSelectionChanged;
  final VoidCallback onConfirm;

  const DatePickerSection({
    super.key,
    required this.showPicker,
    required this.onToggle,
    required this.onSelectionChanged,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onToggle,
          icon: Icon(showPicker ? Icons.close : Icons.date_range),
          label: Text(showPicker ? "Hide Date Picker" : "Select Dates"),
        ),
        const SizedBox(height: 10),
        if (showPicker)
          Column(
            children: [
              SizedBox(
                height: 350,
                child: SfDateRangePicker(
                  onSelectionChanged: onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now(),
                    DateTime.now().add(const Duration(days: 1)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  child: const Text("Confirm Dates"),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
