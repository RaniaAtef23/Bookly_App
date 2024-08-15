import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:flutter/material.dart';
class Book_category extends StatelessWidget {
  final Books book;

  Book_category(this.book);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4), // Reduced padding
      child: SizedBox(
        width: 120, // Fixed width for the image
        height: 200, // Fixed height for the image
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: book.volumeInfo?.imageLinks?.thumbnail != null
              ? Image.network(
            book.volumeInfo!.imageLinks!.thumbnail!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 120); // Placeholder icon size
            },
          )
              : Image.asset(
            "assets/erroe.gif", // Corrected path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}