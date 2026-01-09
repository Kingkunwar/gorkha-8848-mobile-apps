import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/app/functions/input_validators.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/functions/url_launcher_functions.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/about/repo/about_repo.dart';
import 'package:restaurantapp/features/contact_us/iconned_information_widget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _contact() async {
    final response = await locator<AboutRepo>().contact({
      "name": _nameController.text,
      "email": _emailController.text,
      "phone": _phoneNumberController.text,
      "message": _messageController.text,
      "captcha": _captchaController.text
    });
    response.fold(
      (l) {
        showToast(l.message!);
        popPage();
      },
      (r) => showToast(
        r.message!,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _messageController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Contact us",
      ),
      body: Container(
        decoration: getBackgroundDecoration(),
        height: 1.sh,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ScreenPadding(
              child: Column(
                children: [
                  IconnedInformationWidget(
                    icon: FontAwesomeIcons.locationPin,
                    title: RestaurantConstants.location,
                  ),
                  10.verticalSpace,
                  EaseInWidget(
                    onTap: () {
                      launchPhone(RestaurantConstants.phoneNumber);
                    },
                    child: IconnedInformationWidget(
                      icon: FontAwesomeIcons.phone,
                      title: RestaurantConstants.phoneNumber,
                    ),
                  ),
                  10.verticalSpace,
                  EaseInWidget(
                    onTap: () {
                      launchEmail(RestaurantConstants.email);
                    },
                    child: IconnedInformationWidget(
                      icon: Icons.mail,
                      title: RestaurantConstants.email,
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: _nameController,
                    hintText: "Your Name",
                    validator: InputValidators.requiredValidator,
                    labelText: "e.g. Lionel Ritchie",
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: _emailController,
                    hintText: "Your Name",
                    validator: InputValidators.emailValidator,
                    labelText: "e.g. lionelritchie@gmail.com",
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: _phoneNumberController,
                    hintText: "Phone No",
                    validator: InputValidators.requiredValidator,
                    labelText: "e.g. 9844464920",
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: _messageController,
                    hintText: "Message",
                    validator: InputValidators.requiredValidator,
                    labelText: "Enter message",
                  ),
                  10.verticalSpace,
                  PrimaryButton(
                    buttonTitle: "Submit",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _contact();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
