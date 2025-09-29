import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceDetailsCard extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final double pricePerDay;
  final double totalPrice;

  const PriceDetailsCard({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.pricePerDay,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildPriceRow("Start Date", startDate),
            _buildPriceRow("End Date", endDate),
            _buildPriceRow(
              "Price per day",
              "\$${pricePerDay.toStringAsFixed(2)}",
            ),
            _buildPriceRow("Total Price", "\$${totalPrice.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}

Row _buildPriceRow(String title, dynamic value) {
  String textValue;
  if (value is DateTime) {
    textValue = DateFormat('yyyy-MM-dd').format(value);
  } else {
    textValue = value.toString();
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(textValue),
    ],
  );
}
