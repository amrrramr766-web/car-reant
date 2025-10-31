// widgets/car_type_filter_chips.dart
import 'package:car_rent/controller/cars/cubit/cars_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarTypeFilterChips extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const CarTypeFilterChips({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
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
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: carTypes.length,
            itemBuilder: (context, index) {
              final type = carTypes[index];
              final isSelected = selectedType == type;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: ChoiceChip(
                  label: Text(
                    type,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: Colors.deepPurple,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  onSelected: (bool selected) {
                    onTypeSelected(type);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
