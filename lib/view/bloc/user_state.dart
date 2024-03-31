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


