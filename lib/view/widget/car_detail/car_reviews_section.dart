import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';

class CarReviewsSection extends StatelessWidget {
  const CarReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarDeteailDartCubit, CarDeteailDartState>(
      builder: (context, state) {
        if (state is CarDeteailDartError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is CarDeteailDartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarDeteailDartLoaded && state.reviews.isEmpty) {
          return const Center(child: Text("No reviews yet"));
        } else if (state is CarDeteailDartLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reviews",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...state.reviews.map((review) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      review.userFullName != null &&
                              review.userFullName!.isNotEmpty
                          ? review.userFullName![0]
                          : "?",
                    ),
                  ),
                  title: Text(review.userFullName ?? "Anonymous"),
                  subtitle: Text(review.review),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (i) {
                      return Icon(
                        i < review.stars ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                );
              }).toList(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
