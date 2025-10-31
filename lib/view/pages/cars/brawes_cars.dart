// browse_cars.dart
import 'package:car_rent/controller/cars/cubit/cars_cubit.dart';
import 'package:car_rent/view/widget/cars/car_grid_view.dart';
import 'package:car_rent/view/widget/cars/car_type_filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrowseCars extends StatefulWidget {
  const BrowseCars({super.key});

  @override
  State<BrowseCars> createState() => _BrowseCarsState();
}

class _BrowseCarsState extends State<BrowseCars> {
  String selectedType = "All";

  Future<void> _refreshCars() async {
    await context.read<CarsCubit>().fetchCars();
  }

  @override
  void initState() {
    super.initState();
    context.read<CarsCubit>().fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cars", style: TextStyle(fontSize: 20.sp)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          CarTypeFilterChips(
            selectedType: selectedType,
            onTypeSelected: (type) {
              setState(() {
                selectedType = type;
              });
            },
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshCars,
              child: CarGridView(selectedType: selectedType),
            ),
          ),
        ],
      ),
    );
  }
}
