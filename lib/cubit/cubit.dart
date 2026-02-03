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
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'apiKey': '5ad6ff10bc5c4cb4866eaa2defc0067d',
      },
    ).then((value) {
      final List articlesJson = value.data['articles'];
      trending = articlesJson.map((json) => Article.fromJson(json)).toList();
      emit(TrendingNewsGetSuccessState());
    }).catchError((error) {
      emit(TrendingNewsGetErrorState(error.toString()));
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
      url: 'v2/top-headlines',
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
}
