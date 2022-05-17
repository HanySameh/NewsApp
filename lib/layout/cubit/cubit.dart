import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

import '../../modules/business/business_screen.dart';
import '../../modules/sciences/sciences_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List<Widget> screen = [
    const BusinessScreen(),
    const SportsScreen(),
    const SciencesScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '6dd6fba968c44c3d85ef91d727de8de4',
      },
    ).then((value) {
      business = value.data['articles'];
      debugPrint(business.toString());
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '6dd6fba968c44c3d85ef91d727de8de4',
        },
      ).then((value) {
        sports = value.data['articles'];
        debugPrint(sports.toString());
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsSciencesLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '6dd6fba968c44c3d85ef91d727de8de4',
        },
      ).then((value) {
        science = value.data['articles'];
        debugPrint(science.toString());
        emit(NewsGetSciencesSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetSciencesErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSciencesSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '6dd6fba968c44c3d85ef91d727de8de4',
      },
    ).then((value) {
      search = value.data['articles'];
      debugPrint(search.toString());
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }

    if (isDark == true) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ));
      emit(NewsChangeModeState());
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarBrightness: Brightness.light,
      ));
      emit(NewsChangeModeState());
    }
  }
}
