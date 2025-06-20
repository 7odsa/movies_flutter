import 'package:flutter/material.dart';
import 'package:movies_flutter/_core/constants/app_style.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

class MovieCard extends StatelessWidget {
  final String imagePath;
  final String rating;
  final void Function() onTap;

  const MovieCard({super.key, required this.imagePath, required this.rating,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.45,
                          color: ColorsApp.gray,
                          child: Icon(
                            Icons.broken_image,
                            color: ColorsApp.red,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: ColorsApp.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: ColorsApp.yellow, size: 14),
                          SizedBox(width: 2),
                          Text(rating, style: AppStyle.textTheme.displaySmall),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
