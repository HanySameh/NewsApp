abstract class NewsStates{}


class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{
  final String error;
  NewsGetBusinessErrorState(this.error);
}


class NewsSportsLoadingState extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates{
  final String error;
  NewsGetSportsErrorState(this.error);
}


class NewsSciencesLoadingState extends NewsStates{}
class NewsGetSciencesSuccessState extends NewsStates{}
class NewsGetSciencesErrorState extends NewsStates{
  final String error;
  NewsGetSciencesErrorState(this.error);
}

class NewsSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{
  final String error;
  NewsGetSearchErrorState(this.error);
}

class NewsChangeModeState extends NewsStates{}


