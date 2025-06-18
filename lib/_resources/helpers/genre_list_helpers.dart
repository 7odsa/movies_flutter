import 'package:flutter/material.dart';
import 'package:movies_flutter/generated/l10n.dart';

String getLocalizedGenreName(BuildContext context, String genre) {
  switch (genre) {
    case 'action':
      return S.of(context).action;
    case 'adventure':
      return S.of(context).adventure;
    case 'animation':
      return S.of(context).animation;
    case 'anime':
      return S.of(context).anime;
    case 'comedy':
      return S.of(context).comedy;
    case 'crime':
      return S.of(context).crime;
    case 'documentary':
      return S.of(context).documentary;
    case 'drama':
      return S.of(context).drama;
    case 'family':
      return S.of(context).family;
    case 'fantasy':
      return S.of(context).fantasy;
    case 'sport':
      return S.of(context).sport;
    case 'horror':
      return S.of(context).horror;
    case 'music':
      return S.of(context).music;
    case 'thriller':
      return S.of(context).thriller;
    case 'musical':
      return S.of(context).musical;
    case 'mystery':
      return S.of(context).mystery;
    case 'romance':
      return S.of(context).romance;
    case 'sci-fi':
      return S.of(context).sci_fi;
    case 'western':
      return S.of(context).western;
    default:
      return genre;
  }
}
