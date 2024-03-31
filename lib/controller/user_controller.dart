import 'dart:convert';
import 'package:dio/dio.dart';
import '../common/constant.dart';
import '../injection_container.dart';
import '../model/user_article.dart';

abstract class UserRepository {
  Future<List<User>> userList(String email);
  Future<dynamic> deleteUser(User user);
  Future<dynamic> newUser(User user);
  Future<dynamic> updateUser(User user);
}

class UserController implements UserRepository {

  final Dio _dio = sl<Dio>();

  @override
  Future<List<User>> userList(String email) async {
    try {
      var url = "/read.php?email=$email";
      final response = await _dio.get(mBaseURl + url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  @override
  Future<dynamic> deleteUser(User user) async {
    try {
      var url = "/delete.php?email=${user.email}&id=${user.id}";
      final response = await _dio.delete(mBaseURl + url);
      if (response.statusCode == 200) {
        var mResponse = response.data[0]["message"];
        return mResponse;
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<dynamic> newUser(User user) async {
    const String url = "/create.php";
    final response = await _dio.post(
      url, data: jsonEncode(<String, dynamic>{
      'email': user.email,
      'description': user.description,
      'title': user.title,
      'img_link': user.img_link,
    }),
      options: Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }),
    );

    print("response cretae");
    print(response.statusCode);
    print(response);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<dynamic> updateUser(User user) async {
    try {
      var url = "/edit.php?email=${user.email}&id=${user.id}&description=${user.description}&title=${user.title}&img_link=${user.img_link}";
      final response = await _dio.patch(mBaseURl + url);
      if (response.statusCode == 200) {
        var mResponse = response.data[0]["message"];
        return mResponse;
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
