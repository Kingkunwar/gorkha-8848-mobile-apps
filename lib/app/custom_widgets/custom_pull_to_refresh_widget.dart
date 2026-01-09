import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomPullToRefresh extends StatefulWidget {
  final Function() onRefresh;
  final Widget child;
  const CustomPullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  State<CustomPullToRefresh> createState() => _CustomPullToRefreshState();
}

class _CustomPullToRefreshState extends State<CustomPullToRefresh> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () {
        widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      enablePullUp: false,
      enablePullDown: true,
      footer: const SizedBox(),
      header: WaterDropHeader(
        completeDuration: const Duration(milliseconds: 500),
        complete: const SizedBox(),
        waterDropColor: Theme.of(context).primaryColor,
      ),
      child: widget.child,
    );
  }
}
