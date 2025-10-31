import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileHeader extends StatelessWidget {
  final String userName;
  final String? userEmail;
  final String? userImage;

  const UserProfileHeader({
    super.key,
    required this.userName,
    this.userEmail,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // صورة المستخدم
        Center(
          child: CircleAvatar(
            radius: 45.r,
            backgroundImage: NetworkImage(
              userImage ??
                  'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png',
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // الاسم
        Text(
          userName,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 6.h),

        // البريد الإلكتروني
        Text(
          userEmail ?? "No email available",
          style: TextStyle(fontSize: 16.sp, color: Colors.blueGrey),
        ),
        SizedBox(height: 16.h),

        Divider(color: Colors.blue.shade100, thickness: 1.h),
      ],
    );
  }
}
