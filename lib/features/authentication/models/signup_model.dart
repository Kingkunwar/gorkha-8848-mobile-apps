class SignupModel {
  String name;
  String email;
  String password;
  String confirmPassword;

  SignupModel({
    required this.name,
    required this.email,
    required this.confirmPassword,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
    };
  }
}
