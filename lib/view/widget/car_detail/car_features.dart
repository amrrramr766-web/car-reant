import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarFeatures extends StatelessWidget {
  const CarFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: const [
            _FeatureItem(icon: Icons.gps_fixed, label: 'GPS'),
            _FeatureItem(icon: Icons.bluetooth, label: 'Bluetooth'),
            _FeatureItem(icon: Icons.ac_unit, label: 'A/C'),
            _FeatureItem(icon: Icons.camera_rear, label: 'Backup Cam'),
          ],
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18.sp, color: Colors.deepPurple),
      label: Text(label),
      backgroundColor: Colors.deepPurple.shade50,
      side: BorderSide.none,
    );
  }
}
