import 'dart:convert';

import 'package:http/http.dart' as http;
import '../common/constant.dart';
import '../model/user_article.dart';

abstract class UserRepository {
  Future<List<User>> userList(String email);
}

class UserController implements UserRepository {


  @override
  Future<List<User>> userList(String email) async {
    var url = "/read.php?email=$email";

    final response = await http.get(Uri.parse(mBaseURl + url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load user');
    }

  }

}
