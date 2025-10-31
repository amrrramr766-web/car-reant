import 'package:car_rent/controller/car_delteal/cubit/car_deteail_dart_cubit.dart';
import 'package:car_rent/controller/search/cubit/search_cubit.dart';
import 'package:car_rent/controller/search/cubit/search_state.dart';
import 'package:car_rent/data/model/car_model.dart';
import 'package:car_rent/data/model/suggestions.dart';
import 'package:car_rent/server_locator.dart';
import 'package:car_rent/view/pages/CarDetale/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends SearchDelegate {
  final SearchCubit searchCubit;

  Search({required this.searchCubit});
  @override
  List<Widget>? buildActions(BuildContext context) {
    // زر مسح النص (X)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          context.read<SearchCubit>().emit(SearchInitial());
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // زر الرجوع للخلف
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // نعرض نفس نتائج buildSuggestions عند الضغط على Enter
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // استدعاء الكيوبت للبحث أثناء الكتابة
    context.read<SearchCubit>().searchSuggestions(query);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchResults) {
          final List<SuggestionsModel> suggestions = state.suggestions;

          if (suggestions.isEmpty) {
            return const Center(child: Text('لا توجد نتائج مطابقة'));
          }

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return ListTile(
                leading: const Icon(Icons.directions_car),
                title: Text(suggestion.title ?? ''),
                subtitle: Text(suggestion.category ?? ''),
                onTap: () async {
                  // fetch car details
                  final car = await context.read<SearchCubit>().getCarDetails(
                    suggestion.carId ?? 0,
                  );

                  if (car != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) {
                            final cubit = sl<CarDeteailDartCubit>();
                            cubit.fetchReviews(suggestion.carId ?? 0);
                            return cubit;
                          },
                          child: CarDetailsPage(car: car),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("فشل في تحميل تفاصيل السيارة"),
                      ),
                    );
                  }
                },
              );
            },
          );
        } else if (state is SearchNoResults) {
          return const Center(child: Text('لا توجد نتائج مطابقة'));
        } else if (state is SearchError) {
          return Center(child: Text('خطأ: ${state.message}'));
        } else {
          return const Center(child: Text('ابدأ بالبحث عن سيارة'));
        }
      },
    );
  }
}
