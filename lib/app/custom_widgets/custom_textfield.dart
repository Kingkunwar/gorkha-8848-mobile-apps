import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isNumberInput;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool hasContentPadding;
  final Widget? prefixIcon;
  final String? labelText;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final bool? isObscure;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool showUpperText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.readOnly = false,
    this.maxLength = 255,
    this.showUpperText = true,
    this.labelText,
    this.onTap,
    this.prefixIcon,
    this.onChanged,
    this.textInputAction,
    this.hasContentPadding = true,
    this.validator,
    this.suffixIcon,
    this.isNumberInput = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showUpperText) ...{
          Text(
            widget.hintText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 2.h,
          ),
        },
        TextFormField(
          onTap: widget.onTap,
          
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: widget.isObscure!,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.isNumberInput
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : null,
          keyboardType: widget.isNumberInput ? TextInputType.number : null,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged != null
              ? (String val) {
                  widget.onChanged!(val);
                }
              : (String val) {},
          validator: widget.validator,
          // cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            counter: const SizedBox(),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            // hintText: widget.hintText,
            hintText: widget.labelText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
            contentPadding: widget.hasContentPadding
                ? EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 2.w,
                  )
                : null,
            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.red,
                ),
            labelStyle: Theme.of(context).textTheme.titleMedium,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                // width: 2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(

                  // color: Colors.grey,
                  ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
