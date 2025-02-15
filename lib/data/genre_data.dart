import 'package:flutter/material.dart';
import 'package:test4/model/book_genre.dart';

final genres = [
  BookGenre(
    id: 'science_fiction',
    title: 'Science fiction',
    icon: Icons.science_outlined,
  ),
  BookGenre(
    id: 'technical_literature',
    title: 'Technical literature',
    icon: Icons.terminal_outlined,
  ),
  BookGenre(
    id: 'documentary',
    title: 'Documentary',
    icon: Icons.movie_outlined,
  ),
  BookGenre(
      id: 'classical_literature',
      title: 'Classical Literature',
      icon: Icons.music_note_outlined),
  BookGenre(
    id: 'detective',
    title: 'Detective',
    icon: Icons.content_paste_search_outlined,
  ),
];
