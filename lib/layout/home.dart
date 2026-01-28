import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_pp/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
        builder: (context, state) {
          final cubit = NewsCubit.get(context);


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
                        //colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn ),
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
                  Row(
                    children: [
                      Text('Trending',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: bodyTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32,),
                  if (cubit.trending.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (cubit.trending[0]['urlToImage'] != null)
                          Image.network(
                            cubit.trending[0]['urlToImage'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                      ]
                  ),


                ],
              ),
            ),
          );
        }
    );
  }
}
