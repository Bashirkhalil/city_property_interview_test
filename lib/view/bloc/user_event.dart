abstract class UserEvent {}

class GetUserEvent extends UserEvent {
  String email ;
  GetUserEvent(this.email);
}
