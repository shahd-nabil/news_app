import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pp/cubit/cubit.dart';
import 'package:news_pp/cubit/states.dart';
import 'package:news_pp/styles/colors.dart';

class CategoriesTabBar extends StatelessWidget {
  const CategoriesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        final cubit = NewsCubit.get(context);

        return DefaultTabController(

          length: cubit.categories.length,
          child: TabBar(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.symmetric(horizontal: 12),
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.blue,
            indicatorWeight: 2,
            labelColor: Colors.black,
            unselectedLabelColor: bodyTextColor,
            labelStyle:  TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
            onTap: (index) {
              final selectedCategory = cubit.categories[index];
              cubit.changeCategory(selectedCategory);

            },
            tabs: cubit.categories
                .map((category) => Tab(text: category))
                .toList(),
          ),
        );
      },
    );
  }
}


