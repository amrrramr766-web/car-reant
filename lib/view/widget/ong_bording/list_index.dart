import 'package:car_rent/l10n/app_localizations.dart';
import 'package:car_rent/view/pages/auth/regster.dart';
import 'package:car_rent/controller/onBording/cubit/on_bording_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListIndex extends StatelessWidget {
  final PageController pageController;
  final int itemCount;

  const ListIndex({
    required this.itemCount,
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<OnBordingCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 🔹 Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                itemCount,
                (dotIndex) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: dotIndex == state ? 30 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: dotIndex == state
                        ? Colors.deepPurple.shade900
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            // 🔹 Next button
            SizedBox(
              width: 80,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade900,
                ),
                onPressed: () async {
                  if (state == itemCount - 1) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString("step", "1");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                      (route) => false,
                    );
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  state == itemCount - 1
                      ? t?.welcomeButton ?? "Start"
                      : t?.nextButton ?? "Next",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
