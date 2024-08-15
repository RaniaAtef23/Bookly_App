import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/presentation/views/Favourite_books.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class BookTile extends StatefulWidget {
  final Books book;

  BookTile(this.book);

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        FavoritesScreen.addFavorite(widget.book);
      } else {
        FavoritesScreen.removeFavorite(widget.book);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Extract properties with null checks
    final imageUrl = widget.book.volumeInfo?.imageLinks?.smallThumbnail;
    final title = widget.book.volumeInfo?.title ?? "No Title Available";
    final authors = widget.book.volumeInfo?.authors?.join(", ") ?? "No Authors Available";
    final saleability = widget.book.saleInfo?.saleability ?? "Unknown";

    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl ?? "",
                    height: 130,
                    width: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/error.gif",
                      width: 80,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 0,
                    child: ValueListenableBuilder<List<Books>>(
                      valueListenable: FavoritesScreen.favoriteBooksNotifier,
                      builder: (context, favoriteBooks, child) {
                        final isFavorite = favoriteBooks.contains(widget.book);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            toggleFavorite();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 33),
            child: Container(
              width: double.infinity,
              height: 150, // Adjust this height as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5), // Add spacing between elements
                  Text(
                    authors,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          saleability,
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            Text("4.8 (2390)", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}