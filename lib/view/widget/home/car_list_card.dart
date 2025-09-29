import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/server_locator.dart';
import 'package:car_rent/view/pages/CarDetale/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarListCard extends StatelessWidget {
  final List<CarModel> cars;
  const CarListCard({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return GestureDetector(
            key: ValueKey(car.carId),
            onTap: () {
              if (car.isAvailable) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) {
                        final cubit = sl<CarDeteailDartCubit>();
                        cubit.fetchReviews(car.carId);
                        return cubit;
                      },
                      child: CarDetail(car: car),
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 170,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: car.imageUrl,
                            height: 160,
                            width: 160,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              height: 160,
                              width: 160,
                              color: Colors.grey[300],
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          car.brand,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          // 👈 يحل مشكلة overflow
                          child: Text(
                            '${car.model} ${car.year} ${car.gear} ${car.gas}',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          '\$${car.pricePerDay}/day',
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    if (!car.isAvailable)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Not Available",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
