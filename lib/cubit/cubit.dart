import 'package:news_pp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(InitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);

  List<dynamic>trending=[];
  void getTrending(){
    emit(TrendingNewsGetLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
      query:{
        'country': 'us',
        'apiKey':'5ad6ff10bc5c4cb4866eaa2defc0067d',
      },
    ).then((value){
      trending=value.data['articles'];
      //print(business[0]['title']);
      emit(TrendingNewsGetSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(TrendingNewsGetErrorState(error.toString()));
    });
  }
}