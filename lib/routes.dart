import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Import Screens and Cubits
import 'Screens/Login/Login/login_screen.dart';
import 'Screens/Login/Login/Logic/login_cubit.dart';
import 'Screens/Login/Login/Logic/login_repository.dart';

import 'Screens/MyOrder/MyOrder/myorder_screen.dart';
import 'Screens/MyOrder/MyOrder/Logic/myorder_cubit.dart';
import 'Screens/MyOrder/MyOrder/Logic/myorder_repo.dart';

import 'Screens/SignUp/SignUp/sign_up_screen.dart';
import 'Screens/SignUp/SignUp/logic/signup_cubit.dart';
import 'Screens/SignUp/SignUp/logic/signup_repository.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(LoginRepository(), InternetConnectionChecker()),
            child: LoginScreen(),
          ),
        );

      case "/myOrder":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MyorderCubit(MyorderRepo(),InternetConnectionChecker()),
            child: MyOrderScreen(),
          ),
        );

      case "/signup":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignUpCubit(SignUpRepo(), InternetConnectionChecker()),
            child: SignupScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
