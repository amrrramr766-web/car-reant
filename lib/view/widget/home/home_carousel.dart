import 'package:car_rent/data/model/on_boarding_model.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  final List<OnBoardingModel> items;
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
          height: 200,
          child: PageView.builder(
            controller: pageController,
            itemCount: items.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(item.image, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Find Your Best Car',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
