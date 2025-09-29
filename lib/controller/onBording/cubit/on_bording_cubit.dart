import 'package:bloc/bloc.dart';

class OnBordingCubit extends Cubit<int> {
  OnBordingCubit() : super(0);

  /// Move to next index if available
  int nextIndex(int itemCount) {
    final newIndex = (state < itemCount - 1) ? state + 1 : state;
    emit(newIndex);
    return newIndex;
  }

  /// Update index directly
  void updateIndex(int index) {
    emit(index);
  }
}
