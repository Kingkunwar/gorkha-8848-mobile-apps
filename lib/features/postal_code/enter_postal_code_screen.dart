import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/features/cart/widgets/enter_postal_code_widget.dart';

class EnterPostalCodeScreen extends StatefulWidget {
  const EnterPostalCodeScreen({super.key});

  @override
  State<EnterPostalCodeScreen> createState() => EnterPostalCodeScreenState();
}

class EnterPostalCodeScreenState extends State<EnterPostalCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Enter Postal Code",
      ),
      body: Container(
        decoration: getBackgroundDecoration(),
        height: 1.sh,
        child: const EnterPostalCodeWidget(),
      ),
    );
  }
}
