abstract class NewsStates {}
class InitialState extends NewsStates{}
class TrendingNewsGetLoadingState extends NewsStates{}
class TrendingNewsGetSuccessState extends NewsStates{}
class TrendingNewsGetErrorState extends NewsStates{ late final String error;
TrendingNewsGetErrorState(this.error);
}