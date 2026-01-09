//should be in order of processing, processed and failure
import 'package:flutter/material.dart';
import 'package:restaurantapp/app/custom_widgets/custom_circular_progress_indicator.dart';

renderUIBloc(List<dynamic> states, Widget successWidget, dynamic currentState) {
  if (currentState == states[0]) {
    return const Center(
      child: CustomCircularProgressIndicator(),
    );
  } else if (currentState == states[1]) {
    return successWidget;
  } else if (currentState == states[2]) {
    return Center(
      child: Text(currentState.failure!.message ?? ""),
    );
  }
  return const SizedBox();
}
