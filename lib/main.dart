import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'Screens/Login/Login/login_screen.dart';
import 'Screens/MyOrder/MyOrder/Logic/myorder_cubit.dart';
import 'Screens/MyOrder/MyOrder/Logic/myorder_repo.dart';
import 'Screens/MyOrder/MyOrder/myorder_screen.dart';
import 'Screens/SignUp/SignUp/logic/signup_cubit.dart'; // Import SignupCubit
import 'Screens/SignUp/SignUp/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyorderCubit(MyorderRepo(),InternetConnectionChecker()),
        ), BlocProvider(
          create: (context) => SignUpCubit(SignUpRepo(),InternetConnectionChecker(), // Provide the second argument
          ),


        )],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/myOrder': (context) => MyOrderScreen(),
          '/signup': (context) => SignupScreen(),
          // Add more routes if needed
        },
        onGenerateRoute: (settings) {
          // Handle any dynamic routes here
          return null;
        },
      ),
    );
  }
}
