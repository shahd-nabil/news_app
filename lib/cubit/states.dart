abstract class NewsStates {}
class InitialState extends NewsStates{}
class TrendingNewsGetLoadingState extends NewsStates{}
class TrendingNewsGetSuccessState extends NewsStates{}
class TrendingNewsGetErrorState extends NewsStates{ late final String error;
TrendingNewsGetErrorState(this.error);
}
class NewsArticlesCategoryLoadingState extends NewsStates{}
class NewsArticlesCategorySuccessState extends NewsStates{}
class NewsArticlesCategoryErrorState extends NewsStates{ late final String error;
NewsArticlesCategoryErrorState(this.error);
}
class NewsChangeCategoryState extends NewsStates{}
class NewsSearchLoadingState extends NewsStates{}
class NewsSearchSuccessState extends NewsStates{}
class NewsSearchErrorState extends NewsStates{ late final String error;
NewsSearchErrorState(this.error);
}