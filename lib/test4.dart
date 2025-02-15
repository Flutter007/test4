import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test4/screens/books_screen.dart';

class Test4 extends StatefulWidget {
  const Test4({super.key});

  @override
  State<Test4> createState() => _Test4State();
}

class _Test4State extends State<Test4> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '100 Books a year!',
          style: GoogleFonts.alexandria(textStyle: theme.textTheme.bodyLarge!),
        ),
        toolbarHeight: 50,
      ),
      body: BooksScreen(),
    );
  }
}
