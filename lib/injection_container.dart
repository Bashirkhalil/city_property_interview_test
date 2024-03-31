import 'dart:convert';
import 'package:city_property_flutter_interview_test/view/bloc/user_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'common/constant.dart';
import 'controller/user_controller.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

Future<void> init() async {

  // inject Dio
  registerDio();

  // register controller
  registerController();

  // Bloc
  registerBloc();

}

void registerDio() {
  var options = BaseOptions(baseUrl: mBaseURl);
  final dio = Dio(options);
  sl.registerLazySingleton(() => dio);
}


// Controller register
void registerController() {
 sl.registerLazySingleton<UserController>(() => UserController());
}

// Blocs register
void registerBloc() {
  sl.registerLazySingleton<UserBloc>(() => UserBloc(mUserController: sl()));
}



