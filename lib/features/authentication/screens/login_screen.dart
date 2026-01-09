import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/input_validators.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/checkout/screens/complete_order_screen.dart';
import 'package:restaurantapp/main.dart';

class LoginScreen extends StatefulWidget {
  final CompleteOrderScreenViewModel? vm;
  const LoginScreen({
    super.key,
    this.vm,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  _disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenPadding(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                50.verticalSpace,
                Center(
                  child: Text(
                    RestaurantConstants.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(
                  height: 0.12.sh,
                ),
                CustomTextField(
                  controller: _emailController,
                  validator: InputValidators.emailValidator,
                  hintText: "Email",
                  labelText: "lionelritchie@gmail.com",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  controller: _passwordController,
                  validator: InputValidators.requiredValidator,
                  hintText: "Password",
                  labelText: "Please enter your password",
                  suffixIcon: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: Icon(
                      _isObscure
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeLowVision,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  isObscure: _isObscure,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    log("Found the state");
                    if (state is UserLoggedInState) {
                      if (widget.vm != null) {
                        // Navigator.of(context).popAndPushNamed(
                        //   AppRoutes.completeOrderScreen,
                        //   arguments: widget.vm,
                        // );
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(navigatorKey.currentContext!)
                            .pushNamedAndRemoveUntil(
                          AppRoutes.newDashboardScreen,
                          (route) => false,
                        );
                      }
                    } else if (state is AuthFailureState) {
                      showErrorToast(
                        "Invalid Credentials",
                      );
                    }
                  },
                  child: PrimaryButton(
                    buttonTitle: "Login",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        locator<AuthBloc>().add(
                          UserLoginEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // EaseInWidget(
                //   onTap: () {
                //     Navigator.of(context).pushNamed(
                //       AppRoutes.forgotPasswordScreen,
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(
                //       "Forgot password ? Click to reset",
                //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //             fontWeight: FontWeight.bold,
                //           ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 30.h,
                // ),
                EaseInWidget(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.signupScreen,
                      arguments: widget.vm,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Don't have an account ?",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.newDashboardScreen,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Go to dashboard",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
