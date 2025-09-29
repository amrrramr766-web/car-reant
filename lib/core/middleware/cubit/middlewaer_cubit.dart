import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'middlewaer_state.dart';

class MiddlewaerCubit extends Cubit<MiddlewaerState> {
  MiddlewaerCubit() : super(MiddlewaerInitial());

  Future<void> checkStep() async {
    emit(AppLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final step = prefs.getString("step");

    if (step == "2") {
      emit(AppGoHome());
    } else if (step == "1") {
      emit(AppGoLogin());
    } else {
      emit(AppGoOnBoarding());
    }
  }
}
