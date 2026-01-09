import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/input_validators.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/postal_code/bloc/search_postal_code_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterPostalCodeWidget extends StatefulWidget {
  const EnterPostalCodeWidget({super.key});

  @override
  State<EnterPostalCodeWidget> createState() => _EnterPostalCodeWidgetState();
}

class _EnterPostalCodeWidgetState extends State<EnterPostalCodeWidget> {
  final TextEditingController _postalCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // SuccessPostalCodeModel? successPostalCodeModel;
  // String? errorMessage;
  // List<String> addresses = [];
  String selectedAddress = '';
  String deliveryCharge = '';

  // _checkPostalCode() async {
  //   setState(() {
  //     successPostalCodeModel = null;
  //     errorMessage = null;
  //     selectedAddress = '';
  //   });
  //   final Response? response = await locator<BaseClient>()
  //       .postRequest(path: "/check-postalcode", data: {
  //     "postal_code": _postalCodeController.text,
  //   });
  //   if (response != null &&
  //       response.data['status'] != null &&
  //       response.data['status'] == "success") {
  //     _fetchAddressesFromPostalCode();
  //     setState(() {
  //       successPostalCodeModel = SuccessPostalCodeModel.fromJson(response.data);
  //     });
  //   } else if (response != null && response.data['status'] == "fail") {
  //     setState(() {
  //       errorMessage = response.data['msg'] ?? "Something went wrong.";
  //     });
  //   } else {
  //     setState(() {
  //       errorMessage = "Something went wrong.";
  //     });
  //   }
  // }

  bool everyThingIsSelected(SearchPostalCodeState state) {
    return selectedAddress.isNotEmpty && state is SearchSuccessState;
  }

  @override
  void dispose() {
    locator<SearchPostalCodeBloc>().add(ClearPostalCodeEvent());
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<SearchPostalCodeBloc, SearchPostalCodeState>(
        builder: (context, state) {
          return ScreenPadding(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Enter your postal code",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _postalCodeController,
                          validator: InputValidators.requiredValidator,
                          onChanged: (val) {
                            locator<SearchPostalCodeBloc>().add(
                              SearchForPostalCodeEvent(
                                query: _postalCodeController.text,
                              ),
                            );
                          },
                          hintText: "Postal Code",
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            locator<SearchPostalCodeBloc>().add(
                              SearchForPostalCodeEvent(
                                query: _postalCodeController.text,
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.sync,
                        ),
                      ),
                    ],
                  ),
                  if (state is SearchFailureState) ...{
                    Text(
                      state.failure.message!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.red,
                          ),
                    )
                  },
                  10.verticalSpace,
                  if (state is SearchSuccessState) ...{
                    SizedBox(
                      height: 10.h,
                    ),
                    ScreenPadding(
                      padding: 5.w,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                            5.r,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownMenu<String>(
                                initialSelection: state.fetchedAddresses.first,

                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                onSelected: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    selectedAddress = value!;
                                  });
                                },
                                // trailingIcon: Icon(
                                //   Icons.perm_camera_mic,
                                //   color: Colors.black,
                                // ),
                                // trailingIcon: Icon(
                                //   Icons.keyboard_arrow_down,
                                //   color: Colors.grey,
                                //   size: 30.sp,
                                // ),
                                dropdownMenuEntries: state.fetchedAddresses
                                    .map<DropdownMenuEntry<String>>(
                                  (String value) {
                                    return DropdownMenuEntry<String>(
                                      value: value,
                                      label: value,
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            5.horizontalSpace,
                          ],
                        ),
                      ),
                    )
                  },
                  SizedBox(
                    height: 10.h,
                  ),
                  if (!everyThingIsSelected(state)) ...{
                    // PrimaryButton(
                    //   buttonTitle: "Confirm",
                    //   onTap: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       // _checkPostalCode();
                    //       locator<SearchPostalCodeBloc>().add(
                    //         SearchForPostalCodeEvent(
                    //           query: _postalCodeController.text,
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                  } else
                    Center(
                      child: TextButton(
                        onPressed: () {
                          locator<SearchPostalCodeBloc>()
                              .add(ClearPostalCodeEvent());
                          setState(() {
                            selectedAddress = "";
                          });
                          // Focus.of(context).requestFocus();
                        },
                        child: const Text(
                          "Clear location",
                        ),
                      ),
                    ),
                  const Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Row(
                    children: [
                      Text("Note: If address doesn't load, Please click on "),
                      Icon(
                        Icons.sync,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (everyThingIsSelected(state) &&
                      selectedAddress != AppConstants.pleaseSelectAnAddress)
                    PrimaryButton(
                      buttonTitle: "Proceed",
                      onTap: () {
                        locator<PostalCodeHandlerCubit>().setPostalCode(
                          address: selectedAddress,
                          postalCode: _postalCodeController.text,
                          deliveryCharge: state is SearchSuccessState
                              ? state.deliveryCharge
                              : "0",
                        );
                        pushNamed(
                          context: context,
                          routeName: AppRoutes.selectItemScreen,
                          arguments: 0,
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
