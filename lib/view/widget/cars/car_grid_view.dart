import 'package:car_rent/controller/cars/cubit/cars_cubit.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/view/widget/cars/car_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarGridView extends StatelessWidget {
  final String selectedType;

  const CarGridView({super.key, required this.selectedType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsCubit, CarsState>(
      builder: (context, state) {
        if (state is CarLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarError) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else if (state is CarLoaded) {
          List<CarModel> filteredCars = selectedType == "All"
              ? state.cars
              : state.cars.where((car) => car.brand == selectedType).toList();

          if (filteredCars.isEmpty) {
            return const Center(child: Text("No cars found."));
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 3 / 4.5,
            ),
            itemCount: filteredCars.length,
            itemBuilder: (context, index) {
              final car = filteredCars[index];
              return CarItemCard(car: car);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
