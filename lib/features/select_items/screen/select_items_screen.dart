import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/custom_cart_widget.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/features/pizza_and_sides/screens/pizza_and_sides_screen.dart';
import 'package:restaurantapp/features/select_items/models/menu_items_model.dart';
import 'package:restaurantapp/features/select_items/widgets/floating_cart_widget.dart';

class SelectItemsScreen extends StatefulWidget {
  final int index;
  const SelectItemsScreen({
    super.key,
    required this.index,
  });

  @override
  State<SelectItemsScreen> createState() => _SelectItemsScreenState();
}

class _SelectItemsScreenState extends State<SelectItemsScreen> {
  static List<MenuItemsModel> titles = [
    MenuItemsModel(
      title: "Online Order",
      child: const PizzaAndSidesScreen(),
    ),
    // MenuItemsModel(
    //   title: "Indian & Nepalese",
    //   child: const IndianNepaleseFoodScreen(),
    // ),
    // MenuItemsModel(
    //   title: "Meal Deal",
    //   child: const MealDealScreen(),
    // ),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    _selectedIndex.value = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, index, child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const FloatingCartWidget(),
          appBar: CustomAppBar(
            title: titles[index].title,
            actions: [
              EaseInWidget(
                onTap: () {
                  
                  pushNamed(
                    context: context,
                    routeName: AppRoutes.profileScreen,
                  );
                },
                child: const Icon(
                  Icons.person,
                  // color: Colors.white,
                ),
              ),
              10.horizontalSpace,
              const CustomCartWidget(),
            ],
          ),
          body: Container(
            decoration: getBackgroundDecoration(),
            child: titles[index].child,
          ),
        );
      },
    );
  }
}
