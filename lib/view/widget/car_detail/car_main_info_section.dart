import 'package:flutter/material.dart';
import 'package:car_rent/data/model/car_model.dart';

class CarMainInfoSection extends StatelessWidget {
  final CarModel car;
  const CarMainInfoSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${car.brand} ${car.model} - ${car.year}',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          "This is a comfortable ${car.brand} ${car.model} with ${car.seat} seats, perfect for city rides and long trips.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
