import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookInfoText extends StatelessWidget {
  final String txt;
  final String meaning;
  const BookInfoText({
    super.key,
    required this.txt,
    required this.meaning,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Expanded(
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.left,
              '$txt: $meaning',
              style: GoogleFonts.alexandria(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
