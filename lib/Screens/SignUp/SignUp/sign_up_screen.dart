

import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_cubit.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_repository.dart';
import 'package:cubit_learn/Screens/SignUp/SignUp/logic/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pinput/pinput.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FocusNode firsrFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourFocusNode = FocusNode();
  FocusNode fiveFocusNode = FocusNode();
  FocusNode sixFocusNode = FocusNode();
  FocusNode sevenFocusNode = FocusNode();
  FocusNode eightFocusNode = FocusNode();

  bool obscureText = true;
  bool isVisible = false;
  bool isLoading = false;
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final mobileController = TextEditingController();
  final referralcodeController = TextEditingController();
  final codeController = TextEditingController();
  final passController = TextEditingController();
  final pinController = TextEditingController();
  final otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 30,
    height: 30,
    textStyle: TextStyle(fontSize: 22, color: Colors.black),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade900),
    ),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the focus nodes and controllers
    firsrFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    fourFocusNode.dispose();
    fiveFocusNode.dispose();
    firstController.dispose();
    lastController.dispose();
    mobileController.dispose();
    codeController.dispose();
    passController.dispose();
    super.dispose();
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length != 10) {
      return 'Mobile number must be exactly 10 digits';
    }
    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid pincode';
    } else if (value.length != 6) {
      return 'Enter valid pincode';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/login'));
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SignUpCubit(SignUpRepo(), InternetConnectionChecker()),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error), // Show error message
                  backgroundColor: Colors.red, // Red background for errors
                ),
              );
            } else if (state is SignUpOtpSend) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('OTP sent successfully'), // Success message
                  backgroundColor: Colors.green, // Green background for success
                ),
              );
            } else if (state is SignUpSuccess) {
              Navigator.pushNamed(context, '/login');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Registration successful'), // Success message
                  backgroundColor: Colors.green, // Green background for success
                ),
              );
            }
            else if (state is NoInternetState) {
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
            final cubit = context.read<SignUpCubit>();
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          'To access your orders, offers & more!',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          focusNode: firsrFocusNode,
                          controller: firstController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2),
                            ),
                            labelText: 'First Name',
                          ),
                          validator: _validateFirstName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(secondFocusNode);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          focusNode: secondFocusNode,
                          controller: lastController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2),
                            ),
                            labelText: 'Last Name',
                          ),
                          validator: _validateLastName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(thirdFocusNode);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          focusNode: thirdFocusNode,
                          controller: mobileController,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2),
                            ),
                            labelText: 'Mobile Number',
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(11.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Visibility(
                                  visible: isVisible,
                                  child: Text(
                                    'Change',
                                    style: TextStyle(
                                      color: Color(0xff164175),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          validator: _validateMobile,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fourFocusNode);
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          focusNode: fiveFocusNode,
                          controller: referralcodeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2),
                            ),
                            labelText: 'Referral Code(Optional)',
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(sixFocusNode);
                          },
                        ),
                        SizedBox(height: 10),
                        Visibility(
                          visible: isVisible,
                          child: Text(
                            'You will receive OTP shortly',
                            style: TextStyle(
                              color: Color(0xff164175),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          visible: isVisible,
                          child: Row(
                            children: [
                              Pinput(
                                focusNode: sixFocusNode,
                                defaultPinTheme: defaultPinTheme,
                                length: 4,
                                controller: otpController,

                              ),
                              SizedBox(width: 20),
                              Visibility(
                                visible: isVisible,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      otpController.clear();
                                      cubit.onOtpSend(firstName: firstController.text,
                                          lastName: lastController.text,
                                          phone: mobileController.text,
                                          referral: referralcodeController.text);
                                    });

                                  },
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: Color(0xff164175),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: isVisible,
                          child: TextFormField(
                            focusNode: sevenFocusNode,
                            controller: codeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              labelText: 'Pincode',
                            ),
                            validator: _validatePincode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(eightFocusNode);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: isVisible,
                          child: TextFormField(
                            focusNode: eightFocusNode,
                            controller: passController,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (isVisible) {
                                // Proceed with sign-up submission
                                cubit.onSignUpSubmit(
                                  firstName: firstController.text,
                                  lastName: lastController.text,
                                  phone: mobileController.text,
                                  referral: referralcodeController.text,
                                  pinCode: codeController.text,
                                  password: passController.text,
                                  otp: otpController.text,
                                );

                              } else {
                                // Send OTP
                                cubit.onOtpSend(
                                  firstName: firstController.text,
                                  lastName: lastController.text,
                                  phone: mobileController.text,
                                  referral: referralcodeController.text,
                                ).then((_) {
                                  // Update visibility after OTP is successfully sent
                                  setState(() {
                                    isVisible = true; // Show additional fields and OTP input
                                  });
                                }).catchError((error) {
                                  // Handle error if OTP sending fails
                                  print('Error sending OTP: $error');
                                });

                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(320, 55),
                            backgroundColor: Color(0xff164175),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Back to Login',
                              style: TextStyle(
                                color: Color(0xff164175),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                if (state is SignUpContinue)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
