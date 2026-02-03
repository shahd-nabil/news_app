import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_pp/shared/components/home/Categories_tab.dart';
import 'package:news_pp/shared/components/home/heading_row.dart';
import 'package:news_pp/shared/components/texts/small.dart';
import 'package:news_pp/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../data_models/news_model.dart';
import '../shared/components/texts/medium.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            backgroundColor: Colors.white,
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
                    SearchBar(
                      padding: WidgetStateProperty.resolveWith((states) =>
                          EdgeInsets.symmetric(horizontal: 14),
                      ),
                      trailing: [
                        SvgPicture.asset(
                          'assets/icons/filter.svg',
                        ),
                      ],
                      elevation: WidgetStateProperty.all(0),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateOutlinedBorder.resolveWith((states) =>
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: bodyTextColor,
                            ),
                          )),
                      leading: SvgPicture.asset(
                        'assets/icons/search.svg',
                      ),
                      hintText: 'Search',
                      hintStyle: WidgetStateTextStyle.resolveWith((states) =>
                          TextStyle(color: Colors.grey,),
                      ),
                    ),
                    SizedBox(height: 16,),
                   HeadingRow(onSeeAllPressed: (){}, title: 'Trending'),
                    SizedBox(height: 16,),
                    if (firstArticle == null)
                      SizedBox(
                          height: 290,
                          width: double.infinity,
                          child: const Center(child: CircularProgressIndicator()))
                    else
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  firstArticle.urlToImage ?? 'https://cdn-icons-png.flaticon.com/512/3875/3875172.png',
                                  width: double.infinity,
                                 height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 32),
                            MediumText(
                             firstArticle.title ?? '',
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                SmallText(
                                 firstArticle.source ?? '',
                                ),
                                const SizedBox(width: 12),
                                 Icon(CupertinoIcons.clock,size: 18,color: bodyTextColor),
                                const SizedBox(width: 4),
                                SmallText(
                                  firstArticle.publishedAt?.toIso8601String().split('T').first ?? '',

                                ),
                                Spacer(),
                                SmallText('...')
                              ],
                            ),


                          ]
                      ),
                    SizedBox(height: 16,),
                    HeadingRow(onSeeAllPressed: (){}, title: 'Latest'),
                    SizedBox(height: 16,),
                    CategoriesTabBar(),
                    SizedBox(height: 16,),
                    cubit.latest.isEmpty ? const Center(child: CircularProgressIndicator()):
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.latest.length,
                      itemBuilder: (context, index) {
                        final article = cubit.latest[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  article.urlToImage ??
                                      'https://cdn-icons-png.flaticon.com/512/3875/3875172.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(article.title ?? '',fontSize: 12,maxLines:3),
                                    const SizedBox(height: 8),
                                        SmallText(article.source ?? '',fontSize: 12,color: Colors.grey,),
                                    const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(CupertinoIcons.clock,size: 14,color: Colors.grey),
                                           const SizedBox(width: 4),
                                            SmallText(
                                              article.publishedAt?.toIso8601String().split('T').first ?? '',
                                                fontSize: 12,color: Colors.grey,
                                            ),
                                            Spacer(),
                                            SmallText('...',fontSize: 12,color: Colors.grey,),
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index)=>Divider(
                      thickness: 1,
                      color: Colors.grey[200],
                    ),
                    )
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
