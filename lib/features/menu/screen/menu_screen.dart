// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
// import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
// import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
// import 'package:restaurantapp/app/functions/get_background_decoration.dart';
// import 'package:restaurantapp/app/functions/navigation_functions.dart';
// import 'package:restaurantapp/app/routes/app_routes.dart';
// import 'package:restaurantapp/core/constants/app_colors.dart';
// import 'package:restaurantapp/core/constants/asset_source.dart';
// import 'package:restaurantapp/features/dashboard/widgets/footer_widget.dart';
// import 'package:restaurantapp/features/menu/widgets/food_allergy_widget.dart';
// import 'package:restaurantapp/main.dart';

// class MenusViewModel {
//   String title;
//   String routeName;

//   MenusViewModel({
//     required this.title,
//     required this.routeName,
//   });
// }

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   List<MenusViewModel> items = [
//     MenusViewModel(
//       title: "Online Order",
//       // routeName: AppRoutes.pizzaAndSidesScreen,
//       routeName: AppRoutes.selectItemScreen,
//     ),
//     // MenusViewModel(
//     //   title: "Reservation",
//     //   // routeName: AppRoutes.pizzaAndSidesScreen,
//     //   routeName: AppRoutes.reservationScreen,
//     // ),
//     // MenusViewModel(
//     //   title: "Indian & Nepalese",
//     //   routeName: AppRoutes.selectItemScreen,
//     // ),
//     // MenusViewModel(
//     //   title: "Meal Deal",
//     //   routeName: AppRoutes.selectItemScreen,
//     // ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(
//           showBackArrow: true,
//           actions: [
//             // const CustomCartWidget(),
//             IconButton(
//               onPressed: () {
//                 pushNamed(
//                   context: context,
//                   routeName: AppRoutes.profileScreen,
//                 );
//               },
//               icon: const Icon(
//                 Icons.person,
//               ),
//             )
//           ],
//         ),
//         body: Container(
//           decoration: getBackgroundDecoration(),
//           child: Column(
//             children: [
//               const ScreenPadding(
//                 child: FoodAllergyWidget(),
//               ),
//               20.verticalSpace,
//               Expanded(
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   separatorBuilder: (context, index) => SizedBox(
//                     height: 20.h,
//                   ),
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.symmetric(
//                         horizontal: 10.w,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: AppColors.primaryColor,
//                         ),
//                         image: const DecorationImage(
//                             image: ExactAssetImage(
//                               AssetSource.dashboardBackground,
//                             ),
//                             fit: BoxFit.cover,
//                             opacity: 0.5),
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Text(
//                             items[index].title,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge!
//                                 .copyWith(),
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           PrimaryButton(
//                             onTap: () {
//                               pushNamed(
//                                 context: navigatorKey.currentContext!,
//                                 routeName: items[index].routeName,
//                                 arguments: index,
//                               );
//                             },
//                             buttonTitle: "Click and Order",
//                             isWidthLimited: true,
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                         ],
//                       ),
//                     );
//                     // return ListTile(
//                     //   onTap: () {
//                     //     pushPage(
//                     //       context: context,
//                     //       routeName: items[index].routeName,
//                     //     );
//                     //   },
//                     //   title: Text(
//                     //     items[index].title,
//                     //     style: Theme.of(context).textTheme.bodyLarge,
//                     //   ),
//                     // );
//                   },
//                 ),
//               ),
//               FooterWidget(),
//             ],
//           ),
//         ));
//   }
// }
