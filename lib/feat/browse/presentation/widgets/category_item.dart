import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/colors.dart';
import 'package:movies_flutter/_resources/helpers/genre_list_helpers.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.onItemTapped,
    required this.isSelectedItem,
    required this.genreName,
  });

  final void Function() onItemTapped;
  final bool isSelectedItem;
  final String genreName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTapped,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsApp.yellow),
          color: (isSelectedItem) ? ColorsApp.yellow : Colors.transparent,
        ),
        child: Text(
          getLocalizedGenreName(context, genreName),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: (isSelectedItem) ? ColorsApp.black : ColorsApp.yellow,
          ),
        ),
      ),
    );
  }
}
