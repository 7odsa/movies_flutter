import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_resources/common_widgets/movies_items_list.dart';
import 'package:movies_flutter/generated/l10n.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorsApp.darkGreen,
            hintText: S.of(context).search,
            // TODO
            prefixIcon: Image.asset("assets/search_icon.png"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: EdgeInsets.only(top: 4, left: 4, right: 4),
          ),
        ),
        SizedBox(height: 4),
        Expanded(child: MoviesItemsList(numOfTiles: 2)),
      ],
    );
  }
}
