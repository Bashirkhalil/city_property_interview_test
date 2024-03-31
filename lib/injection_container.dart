import 'dart:convert';
import 'package:city_property_flutter_interview_test/view/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'controller/user_controller.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

Future<void> init() async {

  // register controller
  registerController();

  // Bloc
  registerBloc();

}


// Controller register
void registerController() {
 sl.registerLazySingleton<UserController>(() => UserController());
}

// Blocs register
void registerBloc() {
  sl.registerLazySingleton<UserBloc>(() => UserBloc(mUserController: sl()));
}



