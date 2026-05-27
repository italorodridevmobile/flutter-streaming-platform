class AuthenticationModel {
  String email;
  String password;

  AuthenticationModel({required this.email, required this.password});

  AuthenticationModel.fromJson(Map<String, dynamic> json)
    : email = json['email'],
      password = json['password'];

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
