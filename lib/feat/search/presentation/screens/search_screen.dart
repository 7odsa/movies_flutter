import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: Image.asset("assets/search_icon.png"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: EdgeInsets.all(4),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 12,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                  right: (index % 2 == 0) ? 2 : 0,
                  left: (index % 2 != 0) ? 2 : 0,
                ),
                color: ColorsApp.red,
                child: new Card(
                  child: new GridTile(
                    footer: new Text(index.toString()),
                    child: new Text(
                      index.toString(),
                    ), //just for testing, will fill with image later
                  ),
                ),
              );
            },
            itemCount: 23,
          ),
        ),
      ],
    );
  }
}
