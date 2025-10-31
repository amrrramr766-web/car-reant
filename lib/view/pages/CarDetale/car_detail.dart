import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/view/widget/car_detail/car_bottom_bar.dart';
import 'package:car_rent/view/widget/car_detail/car_features.dart';
import 'package:car_rent/view/widget/car_detail/car_images_slider.dart';
import 'package:car_rent/view/widget/car_detail/car_location.dart';
import 'package:car_rent/view/widget/car_detail/car_reviews_section.dart';
import 'package:car_rent/view/widget/car_detail/car_specifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetailsPage extends StatelessWidget {
  final CarModel car;
  const CarDetailsPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF101C22)
          : const Color(0xFFF5F7F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CarImagesSlider(car: car),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.brand} ${car.model}',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      car.year.toString(),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    CarSpecifications(car: car),
                    SizedBox(height: 20.h),
                    CarFeatures(),
                    SizedBox(height: 20.h),
                    CarReviewsSection(),
                    SizedBox(height: 25.h),
                    CarLocation(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CarBottomBar(car: car),
    );
  }
}
