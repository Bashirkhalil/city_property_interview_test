import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../common/constant.dart';
import '../model/user_article.dart';

abstract class UserRepository {
  Future<List<User>> userList(String email);
  dynamic deleteUser(User user);
  Future<http.Response> newUser(User user);
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

  @override
  deleteUser(User user) async {
    var url = "/delete.php?email=${user.email}&id=${user.id}";
    final response = await http.delete(Uri.parse(mBaseURl + url));
    if (response.statusCode == 200) {
      var mResponse = json.decode(response.body)[0]["message"];
      return mResponse;
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Future<http.Response> newUser(User user) async {
    const String url = "/create.php";

    final response = await http.post(
      Uri.parse(mBaseURl + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'description': user.description,
        'title': user.title,
        'img_link': user.img_link,
        // Add any other data you want to send in the body
      }),
    );

    print("response is");
    print(response.statusCode);
    return response ;

  }


}
