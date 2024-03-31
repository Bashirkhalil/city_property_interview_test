import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../model/user_article.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../widget/user_row.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mUserCubit = BlocProvider.of<UserBloc>(context);
    mUserCubit.add(GetUserEvent("mikehsch@email.com"));

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("User List"),
        ),
        body: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {} ,
            builder: (context, state) {
              print("state is ");
              print(state);

              if (state is UserLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is UserSuccessState) {
                print("Data -> ${state.userList.length}");
                print("Data -> ${state.userList[0].title}");

                return buildUserList(mUserCubit, state.userList);
              }

              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    mUserCubit.add(GetUserEvent("mikehsch@email.com"));
                  },
                  child: const Text('Refresh the page '),
                ),
              );
            }));
  }

  buildUserList(mUserCubit, List<User> userList) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: userList.length,
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemBuilder: (context, index) {
            return UserRow(
              user: userList[index],
              onDelete: (User user) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text(
                            "Are you sure you want to delete this user?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    });
              },
              onEdit: (User user) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Edit"),
                        content: const Text(
                            "Are you sure you want to delete this user?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: const Text("Edit"),
                          ),
                        ],
                      );
                    });
              },
            );
          }),
    );
  }


}
