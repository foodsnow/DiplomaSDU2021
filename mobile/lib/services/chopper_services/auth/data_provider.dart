import 'dart:convert';

import 'package:diploma_flutter_app/cubit/auth/models/user.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  Future<List<User>> getUsersList() async {
    final response =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      print("error hahaha");
      throw Exception('Error fetching users');
    }
  }
}
