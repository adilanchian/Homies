/*
  id: string
  email: string
  homes: []
*/
import 'package:homies/models/home.dart';

class User {
  final String id;
  final String email;
  final String username;
  final List<Home> homes;

  User(this.id, this.email, this.username, {this.homes = const <Home>[]});

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'homes': homes,
      };
}
