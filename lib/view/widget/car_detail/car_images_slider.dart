import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_rent/data/model/car_model.dart';

class CarImagesSlider extends StatelessWidget {
  final CarModel car;
  const CarImagesSlider({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [car.imageUrl, car.imageUrl, car.imageUrl];

    return SliverAppBar(
      expandedHeight: 280.h,
      floating: false,
      pinned: true,
      backgroundColor: Colors.deepPurple,
      title: const Text('Details'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) =>
              CachedNetworkImage(imageUrl: images[index], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
