// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:restaurantapp/core/network/error/network_utils_models.dart';
// import 'package:restaurantapp/features/table_reservation/models/table_availability_model.dart';
// import 'package:restaurantapp/features/table_reservation/repo/table_reservation_repo.dart';

// part 'time_slot_state.dart';

// class TimeSlotCubit extends Cubit<TimeSlotState> {
//   final TableReservationRepo _repo;
//   TimeSlotCubit(this._repo) : super(TimeSlotInitial());
//   fetchTimeSlotAvailability(
//     String date,
//     String partySize,
//   ) async {
//     emit(TimeSlotFetchingState());

//     final response = await _repo.fetchTableAvailability(
//       date: date,
//       partySize: partySize,
//     );
//     emit(
//       response.fold(
//         (l) => TimeSlotFetchedState(
//           data: l,
//         ),
//         (r) => TimeSlotFetchErrorState(
//           failure: r,
//         ),
//       ),
//     );
//   }
// }
