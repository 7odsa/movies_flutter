import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/_resources/state_ui.dart';
import 'package:movies_flutter/feat/movie_details/data/models/MovieDetailsModel.dart';
import 'package:movies_flutter/feat/movie_details/presentation/state_holders/cubit/favourite_cubit.dart';
import 'package:movies_flutter/feat/profile/data/data_sources/profile_remote_ds.dart';
import 'package:movies_flutter/feat/profile/data/repos/profile_repo.dart';
import 'package:movies_flutter/feat/profile/presentation/state_holders/cubit/profile_cubit.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.movie});
  final MovieDetailsModel movie;
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  FavouriteCubit profileCubit = FavouriteCubit(
    ProfileRepo(profileRemoteDs: ProfileRemoteDs()),
  );

  @override
  void initState() {
    profileCubit.isFavorite(widget.movie.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, StateUi<bool, String>>(
      bloc: profileCubit,
      builder: (context, state) {
        if (state is ErrorState) {
          return Center(child: Text(state.error ?? ''));
        } else if (state is SuccessState) {
          return IconButton(
            icon: Icon(
              (state.data ?? false) ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                (state.data ?? false)
                    ? profileCubit.removeFavorite(
                      movieId: widget.movie.id.toString(),
                    )
                    : profileCubit.addFavorite(
                      movieId: widget.movie.id.toString(),
                      imageUrl: widget.movie.image,
                      name: widget.movie.title,
                      rating: widget.movie.rating,
                      year: widget.movie.year,
                    );
              });

              context.read<ProfileCubit>().getFavoriteMovies();
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
