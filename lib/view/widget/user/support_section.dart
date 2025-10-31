import 'package:car_rent/view/widget/user/custom_listT_tle.dart';
import 'package:flutter/material.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: const [
          CustomListTile(icon: Icons.help_center, title: "Help Center"),
          Divider(height: 0),
          CustomListTile(icon: Icons.gavel, title: "Terms of Service"),
        ],
      ),
    );
  }
}
