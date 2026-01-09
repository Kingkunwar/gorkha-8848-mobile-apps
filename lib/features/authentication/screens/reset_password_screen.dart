// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
// import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
// import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
// import 'package:restaurantapp/app/functions/get_background_decoration.dart';
// import 'package:restaurantapp/app/functions/input_validators.dart';
// import 'package:restaurantapp/core/constants/asset_source.dart';
// import 'package:restaurantapp/features/authentication/screens/login_screen.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   const ResetPasswordScreen({super.key});

//   @override
//   State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: 1.sh,
//         decoration: getBackgroundDecoration(),
//         child: ScreenPadding(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: kToolbarHeight,
//                   ),
//                   100.verticalSpace,
//                   Center(
//                     child: getTitleWidget(context),
//                   ),
//                   SizedBox(
//                     height: 0.1.sh,
//                   ),
//                   CustomTextField(
//                     validator: InputValidators.emailValidator,
//                     controller: _emailController,
//                     hintText: "Email",
//                     labelText: "e.g. lionelritchie@gmail.com",
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   PrimaryButton(
//                     buttonTitle: "Reset password",
//                     onTap: () {
//                       if (_formKey.currentState!.validate()) {}
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
