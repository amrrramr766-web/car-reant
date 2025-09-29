import 'package:car_rent/controller/bookin_cubit/cubit/booking_cubit.dart';
import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';
import 'package:car_rent/data/data_sorse/remote/booking/booking_data.dart';
import 'package:car_rent/server_locator.dart';
import 'package:car_rent/view/pages/bookingPage/booking.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetail extends StatelessWidget {
  final CarModel car;
  const CarDetail({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarDeteailDartCubit, CarDeteailDartState>(
      listener: (context, state) {
        if (state is CarDeteailDartError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is CarDeteailDartLoaded) {
          // Handle loaded state if needed
        }
      },
      builder: (context, state) {
        if (state is CarDeteailDartLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        List reviwes = state is CarDeteailDartLoaded ? state.reviews : [];
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    car.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.image_not_supported, size: 80),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.brand} ${car.model} - ${car.year}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "This is a comfortable ${car.brand} ${car.model} with ${car.seat} seats, "
                        "perfect for city rides and long trips.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),

                      // Details
                      _buildDetailRow("Price per day", "\$${car.pricePerDay}"),
                      _buildDetailRow("Plate Number", car.plateNumber),
                      _buildDetailRow("Gas", car.gas),
                      _buildDetailRow("Gear", car.gear),
                      _buildDetailRow("Seats", "${car.seat}"),

                      const SizedBox(height: 24),

                      // Reviews Section
                      // Reviews Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reviews",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          // حالة الخطأ
                          if (state is CarDeteailDartError)
                            Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )
                          // حالة التحميل
                          else if (state is CarDeteailDartLoading)
                            const Center(child: CircularProgressIndicator())
                          // حالة البيانات
                          else if (state is CarDeteailDartLoaded)
                            state.reviews.isEmpty
                                ? const Center(child: Text("No reviews yet"))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.reviews.length,
                                    itemBuilder: (context, index) {
                                      final review = state.reviews[index];
                                      return ListTile(
                                        leading: CircleAvatar(
                                          child: Text(
                                            review.userFullName != null &&
                                                    review
                                                        .userFullName!
                                                        .isNotEmpty
                                                ? review.userFullName![0]
                                                : "?",
                                          ),
                                        ),
                                        title: Text(
                                          review.userFullName ?? "Anonymous",
                                        ),
                                        subtitle: Text(review.review),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(5, (i) {
                                            return Icon(
                                              i < review.stars
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                              size: 16,
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Book Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (_) => BookingCubit(
                                    sl<BookingData>(),
                                  ), // your BookingCubit
                                  child: Booking(car: car),
                                ),
                              ),
                            );
                          },

                          child: const Text("Book Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
