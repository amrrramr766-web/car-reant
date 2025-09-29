import 'package:car_rent/data/data_sorse/remote/auth/login.dart';
import 'package:car_rent/data/model/login_requst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginData loginData;

  LoginCubit(this.loginData) : super(LoginInitial());

  /// تسجيل الدخول
  Future<void> login(LoginRequst loginRequest) async {
    if (loginRequest.email.isEmpty || loginRequest.password.isEmpty) {
      if (!isClosed) {
        emit(
          LoginFailure("البريد الإلكتروني وكلمة المرور لا يمكن أن تكون فارغة"),
        );
      }
      return;
    }

    if (!isClosed) emit(LoginLoading());

    try {
      final response = await loginData.postdata(
        loginRequest.email.trim(),
        loginRequest.password.trim(),
      );

      response.fold(
        (status) {
          if (!isClosed) emit(LoginFailure(status.toString()));
        },
        (data) async {
          if (!isClosed) {
            if (data["userID"] != null) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setInt("userID", data["userID"]);
              await prefs.setString("name", data["name"]);
              await prefs.setString("email", data["email"]);
              await prefs.setString("step", "2"); // لو محتاجها

              emit(LoginSuccess(data["userID"], data["name"], data["email"]));
            } else {
              emit(LoginFailure("الاستجابة من الخادم غير صالحة"));
            }
          }
        },
      );
    } catch (e) {
      if (!isClosed) emit(LoginFailure("حدث خطأ غير متوقع: $e"));
    }
  }

  /// تحميل بيانات المستخدم من SharedPreferences
  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userID");
    final name = prefs.getString("name");
    final email = prefs.getString("email");

    if (userId != null && name != null && email != null) {
      if (!isClosed) emit(LoginSuccess(userId, name, email));
    } else {
      if (!isClosed) emit(LoginInitial());
    }
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!isClosed) emit(LoginInitial());
  }
}
