// ignore_for_file: unnecessary_this

class SignUpModel {
  final String? uName;
  final String? email;
  final String? password;
  // String password;

  // Constructor
  SignUpModel({
    this.uName,
    this.email,
    this.password,
  });

  SignUpModel copy({
    String? uName,
    String? email,
    String? password,
  }) =>
      SignUpModel(
        uName: uName ?? this.uName,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  static SignUpModel fromJson(Map<String, dynamic> json) => SignUpModel(
      uName: json['uName'], email: json['email'], password: json['password']);

  Map<String, dynamic> toJson() => {
        'userName': uName,
        'email': email,
        'password': password,
      };
}
