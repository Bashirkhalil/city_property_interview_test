import 'package:city_property_flutter_interview_test/view/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/user_controller.dart';
import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  // this will inject using get it
  UserController mUserController;

  void emitLoading() => emit(UserLoadingState());
  void emitError({required String error}) => emit(UserErrorState(onError: error));

  UserBloc({required this.mUserController}) : super(UserInitial()) {

    // getEvent
    on<GetUserEvent>((event, emit) async {
      try {
        emit(UserLoadingState());
        var result = await mUserController.userList(event.email);
        emit(UserSuccessState(userList: result));
      } catch (e) {
        emit(UserErrorState(onError: "Error occur -> $e"));
      }
    });

  }

}
