import 'package:city_property_flutter_interview_test/view/bloc/user_bloc.dart';
import 'package:city_property_flutter_interview_test/view/screen/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'MyBlocObserver.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Future.wait([di.init() ,]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:  [
        BlocProvider(
          create: (context) => sl<UserBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner :  false ,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UserListPage(),
      ),
    );
  }
}
