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


    // delete Event
    on<DeleteUserEvent>((event, emit) async {
      try{
        emit(UserLoadingState());
        var result =  await mUserController.deleteUser(event.user);

        emit(UserDeletedSuccessState(msg: result));

      }catch(e){
        emit(UserErrorState(onError: "Error occur -> $e"));
      }
    });


    // new user (create user )
    on<NewUserEvent>((event, emit) async {

      try{
        emit(UserLoadingState());
        var result =  await mUserController.newUser(event.user);
        emit(UserCreateSuccessState(msg: result.toString()));
      }catch(e){
        print(e);
        emit(UserErrorState(onError: "Error occur -> $e"));
      }

    });


    // updateEvent
    on<UpdateUserEvent>((event, emit) async {
      try{
        emit(UserLoadingState());
        var result =  await mUserController.updateUser(event.user);

        emit(UserUpdatedSuccessState(msg: result));

      }catch(e){
        emit(UserErrorState(onError: "Error occur -> $e"));
      }
    });

  }

}
