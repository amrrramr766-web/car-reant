class LoginRequst {
  String email;
  String password;
  LoginRequst({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
