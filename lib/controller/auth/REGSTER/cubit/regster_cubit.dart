import 'package:bloc/bloc.dart';
import 'package:car_rent/data/data_sorse/remote/auth/regster.dart';
import 'package:meta/meta.dart';

part 'regster_state.dart';

class RegsterCubit extends Cubit<RegsterState> {
  final RegsterData regsterData;
  RegsterCubit(this.regsterData) : super(RegsterInitial());

  Future<void> postdata(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    emit(RegsterLoading());
    var response = await regsterData.postdata(name, email, password, phone);
    response.fold(
      (failure) {
        emit(RegsterFailure("فشل الاتصال بالسيرفر"));
      },
      (data) {
        if (data != null && data["userID"] != null) {
          emit(
            RegsterSuccess(
              data["userID"].toString(),
              data["name"].toString(),
              data["email"].toString(),
              data["phone"].toString(),
            ),
          );
        } else {
          emit(RegsterFailure("فشل التسجيل: بيانات غير صحيحة من السيرفر"));
        }
      },
    );
  }
}
