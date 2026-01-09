// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
// import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
// import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
// import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
// import 'package:restaurantapp/app/functions/input_validators.dart';
// import 'package:restaurantapp/app/routes/app_routes.dart';
// import 'package:restaurantapp/features/table_reservation/models/reservation_model.dart';
// import 'package:restaurantapp/features/table_reservation/widgets/check_box_widget.dart';

// class ReservationContactDetailScreen extends StatefulWidget {
//   final ReservationModel reservationModel;

//   const ReservationContactDetailScreen({
//     super.key,
//     required this.reservationModel,
//   });

//   @override
//   State<ReservationContactDetailScreen> createState() =>
//       _ReservationContactDetailScreenState();
// }

// class _ReservationContactDetailScreenState
//     extends State<ReservationContactDetailScreen> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   String countryCode = "GB";

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool _receiveFromRestaurant = false;
//   bool _receiveFromLimited = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Contact Details",
//       ),
//       body: Form(
//         key: _formKey,
//         child: ScreenPadding(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomTextField(
//                   controller: _firstNameController,
//                   hintText: "First Name",
//                   validator: InputValidators.requiredValidator,
//                 ),
//                 CustomTextField(
//                   controller: _lastNameController,
//                   hintText: "Last Name",
//                   validator: InputValidators.requiredValidator,
//                 ),
//                 10.verticalSpace,
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Phone number",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 IntlPhoneField(
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: '',
//                     counter: const SizedBox(),
//                     hintText: 'Phone Number',
//                     border: const OutlineInputBorder(),
//                     focusedBorder: const OutlineInputBorder(),
//                     hintStyle: Theme.of(context).textTheme.titleMedium,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 2,
//                     ),
//                     enabledBorder: const OutlineInputBorder(),
//                   ),
//                   validator: (val) {
//                     if (val != null && val.isValidNumber()) {
//                       return null;
//                     }
//                     return "Please enter a valid number.";
//                   },
//                   initialCountryCode: countryCode,
//                   onCountryChanged: (country) {
//                     debugPrint(country.code);
//                     setState(() {
//                       countryCode = country.code;
//                     });
//                   },
//                   controller: _phoneNumberController,
//                 ),
//                 10.verticalSpace,
//                 CustomTextField(
//                   controller: _emailController,
//                   hintText: "Email Address",
//                   validator: InputValidators.emailValidator,
//                 ),
//                 10.verticalSpace,
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Comments",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 2.h.verticalSpace,
//                 SizedBox(
//                   height: 100.h,
//                   child: TextFormField(
//                     maxLines: 5,
//                     maxLength: 255,
//                     controller: _commentController,
//                     decoration: InputDecoration(
//                       counter: const SizedBox(),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           // width: 2,
//                           color: Colors.grey,
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: const BorderSide(

//                             // color: Colors.grey,
//                             ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                   ),
//                 ),
//                 10.verticalSpace,
//                 CheckBoxWidget(
//                   value: _receiveFromRestaurant,
//                   title:
//                       "I would like to receive news and offers from Ginger & Spices Indian Restaurant",
//                   onChanged: (val) {
//                     setState(() {
//                       _receiveFromRestaurant = !_receiveFromRestaurant;
//                     });
//                   },
//                 ),
//                 10.verticalSpace,
//                 CheckBoxWidget(
//                   value: _receiveFromLimited,
//                   title:
//                       "I would like to receive news and offers from Gingerspice Limited",
//                   onChanged: (val) {
//                     setState(() {
//                       _receiveFromLimited = !_receiveFromLimited;
//                     });
//                   },
//                 ),
//                 20.verticalSpace,
//                 PrimaryButton(
//                   buttonTitle: "Next",
//                   onTap: () async {
//                     if (_formKey.currentState!.validate()) {
//                       debugPrint("Form Validated");
//                       debugPrint(_phoneNumberController.text);
//                       ReservationModel reserve = widget.reservationModel;
//                       ReservationModel newData = reserve.copyWith(
//                         customer: Customer(
//                           firstName: _firstNameController.text,
//                           email: _emailController.text,
//                           surname: _lastNameController.text,
//                           mobile: _phoneNumberController.text,
//                           receiveEmailMarketing: _receiveFromLimited,
//                           receiveRestaurantEmailMarketing:
//                               _receiveFromRestaurant,
//                           receiveResDiaryEmailMarketing: false,
//                           receiveResDiarySmsMarketing: false,
//                           receiveRestaurantSmsMarketing: false,
//                           receiveSmsMarketing: false,
//                         ),
//                       );

//                       Navigator.of(context).pushNamed(
//                         AppRoutes.confirmReservationScreen,
//                         arguments: newData,
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
