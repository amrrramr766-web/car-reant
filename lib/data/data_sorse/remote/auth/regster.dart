import 'package:car_rent/core/class/crud.dart';
import 'package:car_rent/core/class/states_request.dart';
import 'package:car_rent/link_api.dart';
import 'package:dartz/dartz.dart';

class RegsterData {
  Crud crud;
  RegsterData(this.crud);

  Future<Either<StatusRequest, dynamic>> postdata(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    // print("Sending login request to: ${LinkApi.login}"); // Debug print
    /* print(
      "Request body: {email: $email, password: $password} phone: $phone NAME:$name",
    ); */
    var response = await crud.postData(LinkApi.register, {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    });
    //  print("Response received: $response");
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
