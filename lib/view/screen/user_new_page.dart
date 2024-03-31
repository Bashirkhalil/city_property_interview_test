import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../injection_container.dart';
import '../../model/user_article.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../widget/user_row.dart';

class UserNewPage extends StatefulWidget {

  const UserNewPage({super.key});

  @override
  State<UserNewPage> createState() => _UserNewPage();
}

class _UserNewPage extends State<UserNewPage> {

   var mUserBloc =sl<UserBloc>() ;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _emailController;
  late TextEditingController _imageController;


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text:'');
    _emailController = TextEditingController(text:'');
    _imageController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("New User"),
        ),
        body: BlocConsumer<UserBloc, UserState>(
    listener: (context, state) {

      if(state is UserCreateSuccessState) {
        Fluttertoast.showToast(
            msg: "User Create successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        emptyTheTextFiled();
      }

      if(state is UserSuccessState) {
        Fluttertoast.showToast(
            msg: "Error exception",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }


    },
    builder: (context, state) {

      print("state is ");
      print(state);

      if (state is UserLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image'),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(

                  onPressed: () {

                    User newUserUpdateObject  = User(
                      id: 12,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      email: _emailController.text,
                      img_link:_imageController.text,
                    );

                    saveTheNewUser(newUserUpdateObject);

                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      );

    }));

  }

  void saveTheNewUser(User newUserUpdateObject) {

    if(isAnyTextEmpty()){

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Message"),
              content: const Text("Please check some value is empty ?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text("Ok"),
                ),
              ],
            );

          });

    }else{
      mUserBloc.add(NewUserEvent(newUserUpdateObject));
    }

    }

  void emptyTheTextFiled() {
    _titleController.text = '';
    _descriptionController.text = '';
    _emailController.text = '';
    _imageController.text = '';
  }

  bool isAnyTextEmpty() =>
  _titleController.text.isEmpty || _descriptionController.text.isEmpty ||
  _emailController.text.isEmpty || _imageController.text.isEmpty;


}
