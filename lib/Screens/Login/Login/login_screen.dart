import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Logic/login_cubit.dart';
import 'Logic/login_repository.dart';
import 'Logic/login_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Add fluttertoast dependency

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();
  bool obscureText = true;

  @override
  void dispose() {
    mobileController.dispose();
    passController.dispose();
    mobileFocusNode.dispose();
    passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.close))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(LoginRepository(), InternetConnectionChecker()),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else if (state is LoginLoaded) {
              Navigator.pushNamed(context, '/myOrder');
              Fluttertoast.showToast(
                msg: 'Login successful',
                backgroundColor: Colors.green,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else if (state is NoInternetState) {
              Fluttertoast.showToast(
                msg: 'No internet connection.',
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_SHORT,
              );
            }else if(state is InternetRestoredState){
              Fluttertoast.showToast(
                  msg: 'Welcome back \n Now You are onlie',
                backgroundColor: Colors.green,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'To access your orders, offers & more!',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        maxLength: 10,
                        controller: mobileController,
                        focusNode: mobileFocusNode,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2)),
                          hintText: 'Mobile',
                          hintStyle: TextStyle(
                              color: Color(0xff164175), fontSize: 18),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          } else if (value.length != 10) {
                            return 'Mobile number must be exactly 10 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passController,
                        focusNode: passFocusNode,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2)),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Color(0xff164175), fontSize: 18),
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                setState(() => obscureText = !obscureText),
                            child: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 3) {
                            return 'Password must be at least 3 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      state is LoginLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<LoginCubit>(context).login(
                              mobileController.text,
                              passController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 55),
                          backgroundColor: const Color(0xff164175),
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Center(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Color(0xff164175), fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(thickness: 0.7, color: Colors.grey),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 55),
                          backgroundColor: const Color(0xff164175),
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
