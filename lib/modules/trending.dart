import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pp/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/components/article_card.dart';
import '../shared/components/texts/medium.dart';

class Trending extends StatelessWidget {
  const Trending({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       leading:  IconButton(onPressed: (){
         Navigator.pop(context);
       }, icon: Icon(Icons.arrow_back,color: bodyTextColor,)),
       centerTitle: true,
       title: MediumText('Trending',color: bodyTextColor),

actions: [
  IconButton(onPressed: (){},
      icon: Icon(Icons.more_vert_rounded,color: bodyTextColor,)
  ) ,
],


     ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<NewsCubit, NewsStates>(
                  builder: (context, state) {
                 final cubit = NewsCubit.get(context);
                     return ListView.separated(
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: cubit.trending.length,
                         itemBuilder: (context,index){
                           final article = cubit.trending[index];
                       return  ArticleCard(
                         imageUrl: article.urlToImage  ?? 'https://cdn-icons-png.flaticon.com/512/3875/3875172.png',
                         title: article.title ?? '',
                         source: article.source ?? '',
                         publishedAt: article.publishedAt?.toIso8601String().split('T').first ?? '',
                       );
                     },
                       separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 40,),
                     );
                 }
               ),
            ],
          ),
        ),
      ),

    );

  }
}
