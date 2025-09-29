import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_serves_state.dart';

class MyServesCubit extends Cubit<MyServesState> {
  MyServesCubit() : super(MyServesInitial());
}
