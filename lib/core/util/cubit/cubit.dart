import 'dart:convert';
import 'dart:io';

import 'package:demo/core/di/injection.dart';
import 'package:demo/core/error/exceptions.dart';
import 'package:demo/core/network/local/cache_helper.dart';
import 'package:demo/core/network/repository.dart';
import 'package:demo/core/util/cubit/state.dart';
import 'package:demo/core/util/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/launch_model.dart';
import '../../models/pyload_model.dart';
import '../../models/rocket_model.dart';
import '../constants.dart';

class MainCubit extends Cubit<MainState> {
  final Repository _repository;

  MainCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static MainCubit get(context) => BlocProvider.of(context);

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  int currentIndex = 0;
  List<String> mainPageTitles = [
    'Home',
    'Categories',
    'Saved',
    'Account',
  ];

  void bottomChanged(int index) {
    if (index == 3) {
      currentIndex = index;
      emit(BottomChanged());
    }

    currentIndex = index;

    emit(BottomChanged());
  }

  // dark colors
  String scaffoldBackground = '333739';
  String mainColorDark = 'ffffff';
  String mainColorVariantDark = '8a8a89';

  // dark colors
  String secondaryDark = 'ffffff';
  String secondaryVariantDark = '8a8a89';

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  late String family;

  bool isRtl = false;
  bool isDark = false;

  void setThemes({
    required bool dark,
    required bool rtl,
  }) {
    isDark = dark;
    isRtl = rtl;

    // debugPrint('dark mode ------------- $isDark');

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeTheme() {
    family = isRtl ? 'Roboto' : 'Roboto';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 24.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        headline6: TextStyle(
          fontSize: 18.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: HexColor(secondary),
          height: 1.3,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 25.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: secondaryVariant,
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(mainColor),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );

    darkTheme = ThemeData(
      scaffoldBackgroundColor: HexColor(scaffoldBackground),
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : SystemUiOverlayStyle(
                statusBarColor: HexColor(scaffoldBackground),
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: HexColor(grey),
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 24.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        headline6: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: HexColor(secondaryDark),
          height: 1.3,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 25.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  void changeMode({required bool value}) {
    isDark = value;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeLanguage({required bool value}) async {
    isRtl = value;

    sl<CacheHelper>().put('isRtl', isRtl);

    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    changeTheme();

    emit(ChangeLanguageState());
  }

  late TranslationModel translationModel;

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }

  /// getNextLaunch ------------------- start

  LaunchModel? nextLaunchModel;

  Future<void> getNextLaunch() async {
    debugPrint('getNextLaunch------------loading');
    emit(GetNextLaunchLoading());
    await _repository.getNextLaunchRepo().then((value) {
      // success
      nextLaunchModel = LaunchModel.fromJson(value.data);
      debugPrint('getNextLaunch------------success');

      emit(GetNextLaunchSuccess());
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('getNextLaunch------------Error');
      ServerException exception = error as ServerException;
      debugPrint('getNextLaunch------------ServerException error');
      debugPrint(exception.error);
      emit(Error(error.toString()));
    });
  }

// getNextLaunch ------------------- end

  /// getPastLaunches ------------------- start

  List<LaunchModel> pastLaunches = [];

  void getPastLaunches() async {
    debugPrint('getPastLaunches------------loading');
    emit(GetPastLaunchesLoading());
    await _repository.getPastLaunchesRepo().then((value) {
      // success
      value.data.forEach((e) {
        pastLaunches.add(LaunchModel.fromJson(e));
      });
      // nextLaunchModel = LaunchModel.fromJson(value.data);
      debugPrint('getPastLaunches------------success');
      emit(GetPastLaunchesSuccess());
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('getPastLaunches------------Error');
      ServerException exception = error as ServerException;
      debugPrint('getPastLaunches------------ServerException error');
      debugPrint(exception.error);
      emit(Error(error.toString()));
    });
  }

// getPastLaunches -------------------

  /// getLaunch ------------------- start

  LaunchModel? launchModel;

  void getLaunch({required String id}) async {
    launchModel = null;
    debugPrint('getLaunch------------loading');
    emit(GetLaunchLoading());
    await _repository.getLaunchRepo(id: id).then((value) {
      // success
      launchModel = LaunchModel.fromJson(value.data);
      debugPrint('getLaunch------------success');
      emit(GetLaunchSuccess());
      getRocket(id: launchModel!.rocket);
      getPayloads(id: launchModel!.payloads);
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('getLaunch------------Error');
      ServerException exception = error as ServerException;
      debugPrint('getLaunch------------ServerException error');
      debugPrint(exception.error);
      emit(Error(error.toString()));
    });
  }

// getLaunch -------------------

  String formatTime({
    required int parsedTime,
  }) {
    var date = DateTime.fromMicrosecondsSinceEpoch(parsedTime);
    String formattedDate = DateFormat('dd/MM/yyyy, HH:mm').format(date);
    return formattedDate;
  }

  String getTimeRemain({
    required int time,
  }) {
    String formattedDate = formatTime(parsedTime: time);

    var dateOfNow = DateTime.now();
    String dateOfNowFormatted =
        DateFormat('dd/MM/yyyy, HH:mm').format(dateOfNow);
    double remainDays = double.parse(formattedDate.split('/').first) -
        double.parse(dateOfNowFormatted.split('/').first);
    double remainHours =
        double.parse(formattedDate.split(',').last.split(':').first.trim()) -
            double.parse(
                dateOfNowFormatted.split(',').last.split(':').first.trim());
    double remainM = double.parse(formattedDate.split(':').last) -
        double.parse(dateOfNowFormatted.split(':').last);
    String remainTime =
        '${remainDays.toInt()} Days ${remainHours.toInt()} Hours, ${remainM.toInt()} Minutes';
    return remainTime;
  }

  void launchURL({required String url}) async {
    if (!await launch(url)) throw 'Could not launch $url';
    emit(LaunchYoutubeSuccess());
  }

  /// getRocket ------------------- start

  RocketModel? rocketModel;

  void getRocket({required String id}) async {
    rocketModel = null;
    debugPrint('getRocket------------loading');
    emit(GetRocketLoading());
    await _repository.getRocketRepo(id: id).then((value) {
      // success
      rocketModel = RocketModel.fromJson(value.data);
      debugPrint('getRocket------------success');
      emit(GetRocketSuccess());
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('getRocket------------Error');
      ServerException exception = error as ServerException;
      debugPrint('getRocket------------ServerException error');
      debugPrint(exception.error);
      emit(Error(error.toString()));
    });
  }

// getRocket -------------------

  /// getPayloads ------------------- start

  PayloadModel? payloadModel;

  void getPayloads({required String id}) async {
    payloadModel = null;
    debugPrint('getPayloads------------loading');
    emit(GetPayLoadLoading());
    await _repository.getPayloadsRepo(id: id).then((value) {
      // success
      payloadModel = PayloadModel.fromJson(value.data);
      debugPrint('getPayloads------------success');
      emit(GetPayLoadSuccess());
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('getPayloads------------Error');
      ServerException exception = error as ServerException;
      debugPrint('getPayloads------------ServerException error');
      debugPrint(exception.error);
      emit(Error(error.toString()));
    });
  }

// getPayloads -------------------

}
