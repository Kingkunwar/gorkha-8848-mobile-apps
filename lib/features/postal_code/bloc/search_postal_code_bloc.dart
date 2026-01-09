import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_postal_code_event.dart';
part 'search_postal_code_state.dart';

EventTransformer<Event> debounceTransformer<Event>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

class SearchPostalCodeBloc
    extends Bloc<SearchPostalCodeEvent, SearchPostalCodeState> {
  SearchPostalCodeBloc() : super(SearchPostalCodeInitial()) {
    on<PostalCodeInitialEvent>((event, emit) {
      emit(SearchPostalCodeInitial());
    });

    on<SearchForPostalCodeEvent>(
      _onPostalCodeSearch,
      transformer: debounceTransformer(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
    on<ClearPostalCodeEvent>((event, emit) {
      emit(
        SearchPostalCodeInitial(),
      );
    });
  }
  Future<void> _onPostalCodeSearch(SearchForPostalCodeEvent event, emit) async {
    if (state is! SearchSuccessState) {
      emit(SearchingPostalCodeState());
    }
    final response = await locator<BaseClient>().postRequest(
      path: "/check-postalcode",
      data: {
        "postal_code": event.query,
      },
      showDialog: false,
    );
    if (response != null &&
        response.data['status'] != null &&
        response.data['status'] == "success") {
      List<String> fetchedAddresses =
          await fetchAddressesFromPostalCode(event.query);
      fetchedAddresses.insert(
        0,
        AppConstants.pleaseSelectAnAddress,
      );
      emit(
        SearchSuccessState(
          fetchedAddresses: fetchedAddresses,
          deliveryCharge: response.data['delivery_charge'] != null
              ? response.data['delivery_charge'].toString()
              : "0",
        ),
      );
    } else if (response != null && response.data['status'] == "fail") {
      emit(
        SearchFailureState(
          failure: Failure(
            message: response.data['msg'] ?? "Something went wrong.",
          ),
        ),
      );
    } else {
      emit(
        SearchFailureState(
          failure: Failure(
            message: "Something went wrong",
          ),
        ),
      );
    }
  }
}

Future<List<String>> fetchAddressesFromPostalCode(String query) async {
  List<String> addresses = [];
  final Response? response = await locator<BaseClient>()
      .getRequest(path: "/findaddress/${query.replaceAll(" ", "%20")}");
  if (response != null && response.statusCode == 200) {
    addresses = response.data?.cast<String>();
  }
  return addresses;
}
