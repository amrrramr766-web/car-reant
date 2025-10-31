import 'package:flutter/material.dart';

class DriverLicenseSection extends StatelessWidget {
  final TextEditingController licenseNumberController;
  final String selectedCountry;
  final DateTime? expiryDate;
  final Function(String) onCountryChanged;
  final Function(DateTime) onDatePicked;

  const DriverLicenseSection({
    required this.licenseNumberController,
    required this.selectedCountry,
    required this.expiryDate,
    required this.onCountryChanged,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: licenseNumberController,
          decoration: inputDecoration.copyWith(labelText: "License Number"),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: inputDecoration.copyWith(
            labelText: "Issuing Country/State",
          ),
          value: selectedCountry,
          items: const [
            DropdownMenuItem(
              value: "California, USA",
              child: Text("California, USA"),
            ),
            DropdownMenuItem(
              value: "New York, USA",
              child: Text("New York, USA"),
            ),
            DropdownMenuItem(value: "Texas, USA", child: Text("Texas, USA")),
          ],
          onChanged: (val) {
            if (val != null) onCountryChanged(val);
          },
        ),
        const SizedBox(height: 16),
        TextField(
          readOnly: true,
          decoration: inputDecoration.copyWith(
            labelText: "Expiry Date",
            suffixIcon: const Icon(Icons.calendar_today),
            hintText: expiryDate == null
                ? "MM/DD/YYYY"
                : "${expiryDate!.month}/${expiryDate!.day}/${expiryDate!.year}",
          ),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) onDatePicked(picked);
          },
        ),
      ],
    );
  }
}
