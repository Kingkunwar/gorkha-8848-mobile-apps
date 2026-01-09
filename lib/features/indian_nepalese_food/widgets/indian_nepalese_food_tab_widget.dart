import 'package:flutter/material.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/indian_nepalese_food/model/indian_nepalese_food_model.dart';

class IndianNepaleseFoodTabBarWidget extends StatefulWidget {
  final IndianNepaleseFoodFetchedState state;
  final Function() onRefresh;
  const IndianNepaleseFoodTabBarWidget({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  State<IndianNepaleseFoodTabBarWidget> createState() =>
      _IndianNepaleseFoodTabBarWidgetState();
}

class _IndianNepaleseFoodTabBarWidgetState
    extends State<IndianNepaleseFoodTabBarWidget>
    with TickerProviderStateMixin {
  TabController? _controller;
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  List<Widget> tabItems = [];

  @override
  void initState() {
    if (widget.state.foodModel.foodItems != null) {
      _controller = TabController(
        length: widget.state.foodModel.foodItems!.length,
        vsync: this,
      );
      tabItems = widget.state.foodModel.foodItems!
          .map(
            (e) => e.items?.subItems != null
                ? ListView.builder(
                    itemCount: e.items!.subItems!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      SubItem item = e.items!.subItems![index];
                      return ListTile(
                        title: Text(
                          item.title ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          item.price ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    },
                  )
                : const Text(
                    "Nothing found",
                  ),
          )
          .toList();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, index, child) {
        return DefaultTabController(
          length: widget.state.foodModel.foodItems!.length,
          child: Scaffold(
            appBar: CustomAppBar(
              bottom: TabBar(
                controller: _controller,
                isScrollable: true,
                tabs: widget.state.foodModel.foodItems!
                    .map(
                      (e) => Text(
                        e.title ?? '',
                      ),
                    )
                    .toList(),
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: tabItems,
            ),
          ),
        );
      },
    );
  }
}
