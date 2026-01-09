import 'package:flutter/material.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/history/cubit/user_history_cubit.dart';
import 'package:restaurantapp/features/history/widgets/user_history_widget.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  void initState() {
    locator<UserHistoryCubit>().fetchUserHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "My History",
      ),
      body: UserHistoryWidget(),
    );
  }
}
