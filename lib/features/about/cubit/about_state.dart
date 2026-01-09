part of 'about_cubit.dart';

sealed class AboutState {}

final class AboutInitial extends AboutState {}

class AboutFetchingState extends AboutState {}

class AboutFetchedState extends AboutState {
  final AboutModel about;
  AboutFetchedState({
    required this.about,
  });
}

class AboutFetchErrorState extends AboutState {
  final Failure failure;
  AboutFetchErrorState({
    required this.failure,
  });
}
