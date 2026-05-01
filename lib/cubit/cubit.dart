import 'package:flutter/cupertino.dart';
import 'package:news_pp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/dio_helper.dart';
import '../data_models/news_model.dart';



class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState()){
  selectedCategory = 'all'; // set initial category
  getArticlesByCategory(selectedCategory); // fetch its articles immediately
}
  static NewsCubit get(context) => BlocProvider.of(context);

  List<Article> trending = [];
  List<Article> latest = [];

  void getTrending() {
    emit(TrendingNewsGetLoadingState());
    DioHelper.getData(
      endPoint: 'top-headlines',
      query: {
        'country': 'us',
      },
    ).then((value) {
      final List articlesJson = value.data['articles'];
      trending = articlesJson.map((json) => Article.fromJson(json)).toList();
      emit(TrendingNewsGetSuccessState());
    }).catchError((error) {
      emit(TrendingNewsGetErrorState(error.toString()));
      debugPrint(error.toString());

    });
  }
  String selectedCategory = 'all';

  List<String> categories = [
    'All',
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];
  void getArticlesByCategory(String category) {
    emit(NewsArticlesCategoryLoadingState());
    Map<String, dynamic> query = {
      'country': 'us',
      'apiKey': '5ad6ff10bc5c4cb4866eaa2defc0067d',
    };

    if (category != 'all') {
      query['category'] = category;
    }

    DioHelper.getData(
      endPoint: 'top-headlines',
      query: query,
    ).then((value) {
      final List articlesJson = value.data['articles'];
      latest = articlesJson
          .map((json) => Article.fromJson(json))
          .toList();
      emit(NewsArticlesCategorySuccessState());
    }).catchError((error) {

      emit(NewsArticlesCategoryErrorState(error.toString()));
    });
  }

  void changeCategory(String category) {
    selectedCategory = category.toLowerCase();
    getArticlesByCategory(selectedCategory);
    emit(NewsChangeCategoryState());

  }


  List<Article> searchResults = [];
  bool isSearching = false;
  void startSearch() {
    isSearching = true;
    emit(NewsSearchLoadingState());
  }
  void searchArticles(String queryText) {
    emit(NewsSearchLoadingState());
    isSearching = true;

    Map<String, dynamic> query = {
      'q': queryText,
      'sortBy': 'publishedAt',
      'pageSize': 10,

    };
    DioHelper.getData(
      endPoint: 'everything',
      query: query,
    ).then((value) {
      final List articlesJson = value.data['articles'];

      searchResults = articlesJson
          .map((json) => Article.fromJson(json))
          .toList();

      emit(NewsSearchSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
  void stopSearch() {
    isSearching = false;
    searchResults.clear();
    emit(NewsSearchSuccessState());
  }
}
