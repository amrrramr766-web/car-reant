import 'package:car_rent/controller/auth/login/cubit/login_cubit.dart';
import 'package:car_rent/controller/bookin_cubit/cubit/booking_cubit.dart';
import 'package:car_rent/controller/search/cubit/search_cubit.dart';
import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/data/data_sorse/remote/booking/booking_data.dart';
import 'package:car_rent/data/data_sorse/remote/search_data.dart';
import 'package:car_rent/view/pages/user/user.dart';
import 'package:car_rent/view/widget/home/serch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    String userName = "Guest";

    if (state is LoginSuccess) {
      userName = state.name;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => BookingCubit(BookingData(Crud())),
                  child: const ProfileSettingsPage(),
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.deepPurple.shade200,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : "G",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome 👋",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // ✅ Notification + Search
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                  IconButton(
                    onPressed: () {
                      // Reuse existing SearchCubit if available
                      SearchCubit? searchCubit;
                      try {
                        searchCubit = context.read<SearchCubit>();
                      } catch (_) {
                        searchCubit = SearchCubit(SearchData(Crud()));
                      }

                      showSearch(
                        context: context,
                        delegate: Search(searchCubit: searchCubit!),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
