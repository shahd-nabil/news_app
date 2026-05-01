import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubit/cubit.dart';
import '../../../styles/colors.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onTap;
  final  Function(String) onSubmitted;



  const SearchSection({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onTap, required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = NewsCubit.get(context);
    return SearchBar(
      padding: WidgetStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(horizontal: 14),
      ),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              controller.clear();
              cubit.stopSearch();
            },
          ),
        SvgPicture.asset('assets/icons/filter.svg'),
      ],
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateOutlinedBorder.resolveWith(
            (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide( color: bodyTextColor),
        ),
      ),
      leading: SvgPicture.asset('assets/icons/search.svg'),
      hintText: 'Search',
      controller: controller,
        textStyle: WidgetStateTextStyle.resolveWith((states) =>
            TextStyle(color: Colors.black,),),
        hintStyle: WidgetStateTextStyle.resolveWith((states) =>
            TextStyle(color: Colors.grey,),),
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,



    );
  }
}