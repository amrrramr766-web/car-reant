import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';
import 'package:car_rent/controller/cars/cubit/cars_cubit.dart';
import 'package:car_rent/server_locator.dart';
import 'package:car_rent/view/pages/CarDetale/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/data/model/car_model.dart';

class BrowseCars extends StatefulWidget {
  const BrowseCars({super.key});

  @override
  State<BrowseCars> createState() => _BrowseCarsState();
}

class _BrowseCarsState extends State<BrowseCars> {
  String selectedType = "All"; // النوع المختار حالياً

  @override
  void initState() {
    super.initState();
    context.read<CarsCubit>().fetchCars(); // تحميل السيارات عند فتح الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Row لاختيار النوع
          SizedBox(
            height: 50,
            child: BlocBuilder<CarsCubit, CarsState>(
              builder: (context, state) {
                List<String> carTypes = ["All"];

                if (state is CarLoaded) {
                  carTypes.addAll(
                    state.cars.map((car) => car.brand).toSet().toList(),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: carTypes.length,
                  itemBuilder: (context, index) {
                    final type = carTypes[index];
                    final isSelected = selectedType == type;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(type),
                        selected: isSelected,
                        selectedColor: Colors.deepPurple,
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedType = type;
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // GridView للسيارات
          Expanded(
            child: BlocBuilder<CarsCubit, CarsState>(
              builder: (context, state) {
                if (state is CarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CarError) {
                  return Center(child: Text("Error: ${state.errorMessage}"));
                } else if (state is CarLoaded) {
                  // فلترة السيارات حسب النوع
                  List<CarModel> filteredCars = selectedType == "All"
                      ? state.cars
                      : state.cars
                            .where((car) => car.brand == selectedType)
                            .toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      itemCount: filteredCars.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3 / 4,
                          ),
                      itemBuilder: (context, index) {
                        final car = filteredCars[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  car.imageUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                car.brand,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                car.isAvailable ? "Available" : "Not Available",
                                style: TextStyle(
                                  color: car.isAvailable
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) {
                                          final cubit =
                                              sl<CarDeteailDartCubit>();
                                          cubit.fetchReviews(
                                            car.carId,
                                          ); // fetch reviews immediately
                                          return cubit;
                                        },
                                        child: CarDetail(car: car),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // contrast with background
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
