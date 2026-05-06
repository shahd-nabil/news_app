import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_pp/shared/components/home/Categories_tab.dart';
import 'package:news_pp/shared/components/home/articles.dart';
import 'package:news_pp/shared/components/home/heading_row.dart';
import 'package:news_pp/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../data_models/news_model.dart';
import '../shared/components/home/search.dart';
import '../shared/components/home/trending.dart';


class Home extends StatelessWidget {
   Home({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
        builder: (context, state) {
          final cubit = NewsCubit.get(context);
          Article? firstArticle;
          if (cubit.trending.isNotEmpty) {
            firstArticle = cubit.trending.first;
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          )
                          ]

                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {}, icon:
                      SvgPicture.asset(
                        'assets/icons/notification.svg',
                      ),
                      )
                  ),
                )
              ],
              title: Image.asset(
                'assets/images/Vector.png',

              ),

            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchSection(
                      controller: searchController,
                      onChanged: (value) {
                        cubit.searchArticles(value);
                    },
                      onTap: () {
                        cubit.startSearch();
                      }, onSubmitted: (value) {
                        cubit.searchArticles(value);
                        if (searchController.text.isEmpty){
                          cubit.stopSearch();
                        }
                        FocusScope.of(context).unfocus();
                    },),
                    SizedBox(height: 16,),
                    if (cubit.isSearching)
                     ...[if(cubit.searchResults.isEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                     else
                       ArticlesListView(articles: cubit.searchResults),
                       ]

                    else ...[
                        SizedBox(height: 16,),
                        TrendingSection(article: firstArticle),
                        SizedBox(height: 16,),
                        HeadingRow(onSeeAllPressed: () {}, title: 'Latest'),
                        SizedBox(height: 16,),
                        CategoriesTabBar(),
                        SizedBox(height: 16,),
                        cubit.latest.isEmpty ? const Center(
                            child: CircularProgressIndicator()) :
                            ArticlesListView(articles: cubit.latest)
          ]
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              elevation: 10,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: bodyTextColor,

              items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.explore_outlined),label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline),label: 'Bookmark'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outlined),label: 'Profile'),

            ],)
          );
        }
    );
  }
}
