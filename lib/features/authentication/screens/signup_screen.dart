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
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/authentication/models/signup_model.dart';
import 'package:restaurantapp/features/checkout/screens/complete_order_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  final CompleteOrderScreenViewModel? vm;
  const SignupScreen({
    super.key,
    this.vm,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  _disposeControllers() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Widget passwordSuffixIcon() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
      child: Icon(
        _isObscure ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeLowVision,
        size: 16,
        color: Colors.grey,
      ),
    );
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
                30.verticalSpace,
                Center(
                  child: Text(
                    RestaurantConstants.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(
                  height: 0.09.sh,
                ),
                CustomTextField(
                  controller: _nameController,
                  hintText: "Name",
                  labelText: "e.g. Lionel Ritchie",
                  validator: InputValidators.requiredValidator,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  controller: _emailController,
                  validator: InputValidators.emailValidator,
                  hintText: "Email",
                  labelText: "lionel@gmail.com",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  controller: _passwordController,
                  validator: (val) {
                    return InputValidators.passwordsValidator(
                      _confirmPasswordController.text,
                      _passwordController.text,
                    );
                  },
                  isObscure: _isObscure,
                  suffixIcon: passwordSuffixIcon(),
                  hintText: "Password",
                  labelText: "Please enter a strong password",
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  isObscure: _isObscure,
                  controller: _confirmPasswordController,
                  suffixIcon: passwordSuffixIcon(),
                  validator: (val) {
                    return InputValidators.passwordsValidator(
                      _passwordController.text,
                      _confirmPasswordController.text,
                    );
                  },
                  hintText: "Confirm password",
                  labelText: "Please re-enter the password",
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UserLoggedInState) {
                      showToast('Registration Successful.');
                      if (state.signupResponse.accessToken != null) {
                        locator<SharedPreferences>().setString(
                          AppConstants.token,
                          state.signupResponse.accessToken!,
                        );
                        if (widget.vm != null) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pushNamed(
                            AppRoutes.newDashboardScreen,
                          );
                        }
                      } else {
                        Navigator.of(context).pop();
                      }
                    } else if (state is AuthFailureState) {
                      showErrorToast(state.failure.message!);
                    }
                  },
                  child: PrimaryButton(
                    buttonTitle: "Register",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        locator<AuthBloc>().add(
                          UserRegistrationEvent(
                            userData: SignupModel(
                              name: _nameController.text,
                              email: _emailController.text,
                              confirmPassword: _confirmPasswordController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a user ?"),
                    SizedBox(
                      width: 5.w,
                    ),
                    EaseInWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
