import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';
import 'package:car_rent/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/view/pages/CarDetale/car_detail.dart';

class CarItemCard extends StatelessWidget {
  final CarModel car;

  const CarItemCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // صورة السيارة
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                child: Image.network(
                  car.imageUrl,
                  height: constraints.maxHeight * 0.45, // 45% من ارتفاع الكارد
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),

              // اسم السيارة والحالة
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    Text(
                      car.brand,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      car.isAvailable ? "Available" : "Not Available",
                      style: TextStyle(
                        color: car.isAvailable
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), // ← يضغط الزر للأسفل دائماً
              // زر التفاصيل
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              final cubit = sl<CarDeteailDartCubit>();
                              cubit.fetchReviews(car.carId);
                              return cubit;
                            },
                            child: CarDetailsPage(car: car),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 15, 1, 39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
