import 'package:car_rent/view/pages/personalDetail/personal_detail_page.dart';
import 'package:car_rent/view/widget/user/custom_listT_tle.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // تنفيذ إجراء عند الضغط على "تفاصيل شخصية"
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalDetailsPage(),
                ),
              );
            },
            child: const CustomListTile(
              icon: Icons.person,
              title: "Personal Details",
            ),
          ),
          const Divider(height: 0),
          const CustomListTile(
            icon: Icons.credit_card,
            title: "Payment Methods",
          ),
          const Divider(height: 0),
          const CustomListTile(icon: Icons.badge, title: "Driving License"),
        ],
      ),
    );
  }
}
