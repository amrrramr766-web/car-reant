import 'package:car_rent/data/model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarousel extends StatelessWidget {
  final List<OfferModel> items;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const HomeCarousel({
    super.key,
    required this.items,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: items.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                margin: EdgeInsets.all(8.0.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(item.imageUrl, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Find Your Best Car',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
