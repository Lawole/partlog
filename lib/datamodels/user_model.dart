import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String? token;

  const User({this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String?,
      token: json['token'] as String?,
    );
  }

  @override
  List<Object?> get props => [email, token];
}
