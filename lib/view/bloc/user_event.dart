import '../../model/user_article.dart';

abstract class UserEvent {}

class GetUserEvent extends UserEvent {
  String email ;
  GetUserEvent(this.email);
}


class DeleteUserEvent extends UserEvent {
  User user ;
  DeleteUserEvent(this.user);
}


class NewUserEvent extends UserEvent {
  User user ;
  NewUserEvent(this.user);
}



class UpdateUserEvent extends UserEvent {
  User user ;
  UpdateUserEvent(this.user);
}