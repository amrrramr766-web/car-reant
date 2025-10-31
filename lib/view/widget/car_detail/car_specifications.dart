import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_rent/data/model/car_model.dart';

class CarSpecifications extends StatelessWidget {
  final CarModel car;
  const CarSpecifications({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specifications',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3.5,
          children: [
            _SpecItem(icon: Icons.person, label: '${car.seat} Passengers'),
            _SpecItem(icon: Icons.door_sliding, label: '4 Doors'),
            _SpecItem(icon: Icons.settings, label: car.gear),
            _SpecItem(icon: Icons.local_gas_station, label: car.gas),
          ],
        ),
      ],
    );
  }
}

class _SpecItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SpecItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22.sp, color: Colors.deepPurple),
        SizedBox(width: 8.w),
        Expanded(child: Text(label)),
      ],
    );
  }
}
