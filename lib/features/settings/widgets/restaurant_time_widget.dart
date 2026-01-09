import 'package:flutter/material.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';

class RestaurantTimeWidget extends StatelessWidget {
  final SettingsFetchedState state;
  const RestaurantTimeWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text(
            "Day",
          ),
        ),
        DataColumn(
          label: Text(
            "Time",
          ),
        ),
      ],
      rows: [
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Sunday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.sundayOpenTime} - ${state.settings.sundayCloseTime} ",
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Monday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.mondayOpenTime} - ${state.settings.mondayCloseTime} ",
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Tuesday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.tuesdayOpenTime} - ${state.settings.tuesdayCloseTime} ",
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Wednesday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.wednesdayOpenTime} - ${state.settings.wednesdayCloseTime} ",
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Thursday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.thursdayOpenTime} - ${state.settings.thursdayCloseTime} ",
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Friday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.fridayOpenTime} - ${state.settings.fridayCloseTime} ",
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            const DataCell(
              Text(
                "Saturday",
              ),
            ),
            DataCell(
              Text(
                "${state.settings.saturdayOpenTime} - ${state.settings.saturdayCloseTime} ",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
