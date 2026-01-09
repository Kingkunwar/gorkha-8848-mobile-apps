import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/table_reservation/models/add_reservation_model.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_model.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_success_model.dart';
import 'package:restaurantapp/features/table_reservation/models/table_availability_model.dart';

abstract class TableReservationRepo {
  Future<Either<AvailabilityModel, Failure>> fetchTableAvailability({
    required String date,
    required String partySize,
  });

  Future<Either<ReservationSuccessModel, Failure>> reserveTable(
      ReservationModel reservation);
  Future<Either<List<String>, Failure>> fetchTimeSlotsForDate(String date);
  Future<Either<Success, Failure>> reserveATable(
      AddReservationModel reservation);
}

class TableReservationImpl implements TableReservationRepo {
  final BaseClient client;

  TableReservationImpl(this.client);

  @override
  Future<Either<AvailabilityModel, Failure>> fetchTableAvailability({
    required String date,
    required String partySize,
  }) async {
    final response = await client.getRequest(
      baseUrl:
          "https://booking.resdiary.com/api/Restaurant/GingerSpicesIndianRestaurant/AvailabilitySearch?date=$date&covers=$partySize&channelCode=ONLINE&areaId=0&availabilityType=Reservation",
      path: "",
    );
    return getParsedData(
      response,
      AvailabilityModel.fromJson,
    );
  }

  @override
  Future<Either<ReservationSuccessModel, Failure>> reserveTable(
      ReservationModel reservation) async {
    final response = await client.postRequest(
      path: "",
      baseUrl:
          "https://thegurkhakitchenmaidstone.com/reservation-flutter",
      showDialog: true,
      data: reservation.toJson(),
    );
    return getParsedData(
      response,
      ReservationSuccessModel.fromJson,
    );
  }

  //++==========================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// THE CODE BELOW IS USED FOR THIS THE GURKHA KITCHEN PROJECT

  @override
  Future<Either<List<String>, Failure>> fetchTimeSlotsForDate(
      String date) async {
    final response = await client.getRequest(path: "/ordertime?date=$date");
    if (response?.statusCode == 200) {
      Map data = response!.data;
      List<String> items = [];
      for (var element in data.keys) {
        items.add(data[element]);
      }
      return Left(items);
    }
    return Right(Failure.fromJson({}));
  }

  @override
  Future<Either<Success, Failure>> reserveATable(
      AddReservationModel reservation) async {
    final response = await client.postRequest(
      path: "",
      baseUrl: "https://thegurkhakitchenmaidstone.com/api/reservation-flutter",
      data: reservation.toMap(),
    );
    if (response?.statusCode == 200) {
      return Left(Success(
        message: "Table reserved successfully.",
      ));
    } else {
      try {
        return Right(Failure.fromJson(response?.data ?? {}));
      } catch (e) {
        return Right(Failure.fromJson({}));
      }
    }
    // return getParsedData(
    //   response,
    //   Success.fromJson,
    // );
  }
}
