import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/about/model/about_model.dart';
import 'package:restaurantapp/features/about/repo/about_repo.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  final AboutRepo _repo;

  AboutCubit(this._repo) : super(AboutInitial());
  fetchAbouts() async {
    if (state is! AboutFetchedState) {
      emit(AboutFetchingState());
      final response = await _repo.fetchAbout();
      emit(
        response.fold(
          (l) => AboutFetchedState(
            about: l,
          ),
          (r) => AboutFetchErrorState(
            failure: r,
          ),
        ),
      );
    }
  }
}
