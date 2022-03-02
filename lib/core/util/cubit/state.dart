import 'package:meta/meta.dart';

@immutable
abstract class MainState {}

class Empty extends MainState {}

class Loading extends MainState {}

class LanguageLoaded extends MainState {}

class BottomChanged extends MainState {}

class ThemeLoaded extends MainState {}

class ChangeModeState extends MainState {}

class ChangeLanguageState extends MainState {}

class Error extends MainState {
  final String error;

  Error(this.error);
}

class GetNextLaunchLoading extends MainState {}

class GetNextLaunchSuccess extends MainState {}

class GetPastLaunchesLoading extends MainState {}

class GetPastLaunchesSuccess extends MainState {}

class GetLaunchLoading extends MainState {}

class GetLaunchSuccess extends MainState {}

class GetRocketLoading extends MainState {}

class GetRocketSuccess extends MainState {}


class GetPayLoadLoading extends MainState {}

class GetPayLoadSuccess extends MainState {}

class LaunchYoutubeSuccess extends MainState {}
