import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/core/class/states_request.dart';
import 'package:car_rent/link_api.dart';
import 'package:dartz/dartz.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  Future<Either<StatusRequest, dynamic>> postdata(
    String email,
    String password,
  ) async {
    //  print("Sending login request to: ${LinkApi.login}"); // Debug print
    //  print("Request body: {email: $email, password: $password}"); // Debug print

    var response = await crud.postData(LinkApi.login, {
      "email": email,
      "password": password,
    });

    //   print("Response received: $response"); // Debug print

    return response.fold(
      (l) {
        //    print("Request failed with status: $l"); // Debug print
        return Left(l);
      },
      (r) {
        //    print("Request succeeded with response: $r"); // Debug print
        return Right(r);
      },
    );
  }
}
