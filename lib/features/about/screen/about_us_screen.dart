// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
// import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
// import 'package:restaurantapp/app/functions/get_background_decoration.dart';
// import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
// import 'package:restaurantapp/features/about/cubit/about_cubit.dart';

// class AboutUsScreen extends StatefulWidget {
//   const AboutUsScreen({super.key});

//   @override
//   State<AboutUsScreen> createState() => _AboutUsScreenState();
// }

// class _AboutUsScreenState extends State<AboutUsScreen> {
//   @override
//   void initState() {
//     locator<AboutCubit>().fetchAbouts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "About us",
//       ),
//       body: Container(
//         decoration: getBackgroundDecoration(),
//         child: BlocBuilder<AboutCubit, AboutState>(
//           builder: (context, state) {
//             if (state is AboutFetchingState) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is AboutFetchedState) {
//               return SingleChildScrollView(
//                 child: ScreenPadding(
//                   child: Html(
//                     data: state.about.details.toString(),
//                   ),
//                 ),
//               );
//             } else if (state is AboutFetchErrorState) {
//               return Center(
//                 child: Text(
//                   "${state.failure.message}",
//                 ),
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
