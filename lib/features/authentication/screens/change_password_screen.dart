import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/input_validators.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/authentication/repo/auth_repo.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  _changePassword() async {
    final response = await locator<AuthRepo>().changePassword({
      "current_password": _currentPasswordController.text,
      "password": _newPasswordController.text,
      "password_confirmation": _confirmPasswordController.text,
    });
    response.fold(
      (l) {
        showToast(l.message!);
        Navigator.of(context).pop();
      },
      (r) => showToast(
        r.message!,
      ),
    );
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Change Password",
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            ScreenPadding(
              child: CustomTextField(
                controller: _currentPasswordController,
                hintText: "Current Password",
                isObscure: true,
                labelText: "Enter your current password",
              ),
            ),
            10.verticalSpace,
            ScreenPadding(
              child: CustomTextField(
                controller: _newPasswordController,
                hintText: "New Password",
                labelText: "Enter a new password",
                isObscure: true,
                validator: (val) {
                  return InputValidators.passwordsValidator(
                    _newPasswordController.text,
                    _confirmPasswordController.text,
                  );
                },
              ),
            ),
            10.verticalSpace,
            ScreenPadding(
              child: CustomTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                labelText: "Please re-enter the new password",
                isObscure: true,
                validator: (val) {
                  return InputValidators.passwordsValidator(
                    _newPasswordController.text,
                    _confirmPasswordController.text,
                  );
                },
              ),
            ),
            10.verticalSpace,
            ScreenPadding(
              child: PrimaryButton(
                buttonTitle: "Submit",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _changePassword();
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
