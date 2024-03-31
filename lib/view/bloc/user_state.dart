import '../../model/user_article.dart';

abstract class UserState {}

class UserInitial extends UserState {}
class UserLoadingState extends UserState {}
class UserErrorState extends UserState {
  String onError ;
  UserErrorState({required this.onError});
}


//  user List success
//------------------------------------------------------------
class UserSuccessState extends UserState {
  List<User> userList = [];
  UserSuccessState({required this.userList});
}



//  user Delete success
//------------------------------------------------------------
class UserDeletedSuccessState extends UserState {
  String msg ;
  UserDeletedSuccessState({required this.msg});
}


//  user new success
//------------------------------------------------------------
class UserCreateSuccessState extends UserState {
  String msg ;
  UserCreateSuccessState({required this.msg});
}

//  user update success
//------------------------------------------------------------
class UserUpdatedSuccessState extends UserState {
  String msg ;
  UserUpdatedSuccessState({required this.msg});
}
