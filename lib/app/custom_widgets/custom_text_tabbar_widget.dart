import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/features/menu/widgets/food_allergy_widget.dart';

class CustomTabbarWidget extends StatefulWidget {
  final List<String> titles;
  final List<Widget> bodies;
  const CustomTabbarWidget({
    super.key,
    required this.titles,
    required this.bodies,
  });

  @override
  State<CustomTabbarWidget> createState() => _CustomTabbarWidgetState();
}

class _CustomTabbarWidgetState extends State<CustomTabbarWidget> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, index, child) {
          return Column(
            children: [
              FoodAllergyWidget(),
              5.verticalSpace,
              SizedBox(
                height: 40.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.titles
                          .map(
                            (e) => ScreenPadding(
                              child: IntrinsicWidth(
                                child: Column(
                                  children: [
                                    EaseInWidget(
                                      onTap: () {
                                        _index.value = widget.titles.indexOf(e);
                                      },
                                      child: Text(
                                        e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                    if (widget.titles.indexOf(e) == index) ...{
                                      Container(
                                        margin: EdgeInsets.only(top: 2.h),
                                        color: AppColors.primaryColor,
                                        height: 2.h,
                                      )
                                    }
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList()),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: widget.titles.length,
                  onPageChanged: (int index) {
                    _index.value = index;
                  },
                  itemBuilder: (context, _) => widget.bodies[index],
                ),
              ),
            ],
          );
        });
  }
}
