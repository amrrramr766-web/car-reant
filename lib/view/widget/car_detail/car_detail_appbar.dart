import 'package:flutter/material.dart';
import 'package:car_rent/data/model/car_model.dart';

class CarDetailAppBar extends StatelessWidget {
  final CarModel car;
  const CarDetailAppBar({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          car.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Center(child: Icon(Icons.image_not_supported, size: 80)),
        ),
      ),
    );
  }
}
