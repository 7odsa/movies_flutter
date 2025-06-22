import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter/feat/movie_details/presentation/widgets/favourites_button.dart'
    show FavoriteButton;
import 'package:movies_flutter/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import '../state_holders/Bloc.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (_) => MovieDetailsBloc()..add(FetchMovieDetails(movieId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).movieDetails),
          centerTitle: true,
        ),
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsLoaded) {
              final movie = state.movieDetails;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: width,
                            height: width * (13 / 9),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                movie.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: FavoriteButton(movie: movie),
                          ),
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_fill,
                                size: 64,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        '${movie.title} (${movie.year})',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      ElevatedButton(
                        onPressed: () async {
                          final url = Uri.parse(
                            'https://www.youtube.com/watch?v=${movie.trailerCode}',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not launch trailer.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Watch Trailer'),
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          _infoIcon(Icons.favorite, '${movie.likes}'),
                          _infoIcon(Icons.visibility, '${movie.views}'),
                          _infoIcon(Icons.star, '${movie.rating}'),
                          _infoIcon(
                            Icons.timer,
                            '${movie.runtime} ${S.of(context).min}',
                          ),
                          _infoIcon(Icons.language, movie.language),
                          _infoIcon(Icons.movie_filter, movie.mpaRating),
                          _infoIcon(
                            Icons.confirmation_number,
                            'IMDB: ${movie.imdbCode}',
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        S.of(context).screenshots,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children:
                            movie.screenshots.map((url) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors
                                            .black, // لون الخلفية يملأ الفراغات
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        url,
                                        fit:
                                            BoxFit
                                                .contain, // يخلي الصورة كاملة من غير قص
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        S.of(context).similar,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            state.similarMovies.map((similarMovie) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => MovieDetailsScreen(
                                            movieId: similarMovie.id,
                                          ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 48) /
                                      2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: Image.network(
                                            similarMovie.image,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                                      Icons.broken_image,
                                                    ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        similarMovie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        S.of(context).summary,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.description,
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 20),

                      if (movie.cast.isNotEmpty) ...[
                        Text(
                          S.of(context).cast,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children:
                              movie.cast.map((actor) {
                                return CastItem(
                                  name: actor.name,
                                  character: actor.characterName,
                                  imageUrl: actor.urlSmallImage,
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],

                      Text(
                        S.of(context).genres,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children:
                            movie.genres
                                .map((genre) => Chip(label: Text(genre)))
                                .toList(),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is MovieDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _infoIcon(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.yellow[700]),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}

class CastItem extends StatelessWidget {
  final String name;
  final String character;
  final String? imageUrl;

  const CastItem({
    super.key,
    required this.name,
    required this.character,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null ? const Icon(Icons.person) : null,
      ),
      title: Text(name),
      subtitle: Text('Character: $character'),
    );
  }
}
