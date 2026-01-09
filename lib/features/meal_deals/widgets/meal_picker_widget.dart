import 'package:flutter/material.dart';
import 'package:restaurantapp/features/meal_deals/model/meal_deal_model.dart';

class MealPickerWidget extends StatelessWidget {
  final List<Items> items;
  final List<String> texts;
  const MealPickerWidget({
    super.key,
    required this.items,
    required this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: texts.isNotEmpty ? texts.length : items.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pop(texts.isNotEmpty
                ? Items(
                    title: texts[index],
                  )
                : items[index]);
          },
          title: Text(
            texts.isNotEmpty ? texts[index] : items[index].title ?? "",

          ),
        );
      },
    );
  }
}
