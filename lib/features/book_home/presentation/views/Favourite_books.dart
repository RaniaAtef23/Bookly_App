import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/presentation/views/Cart_screen.dart';
import 'package:book_app/features/book_home/presentation/views/widgets/Cart_widget.dart';
import 'package:flutter/material.dart';
class FavoritesScreen extends StatefulWidget {
  static ValueNotifier<List<Books>> favoriteBooksNotifier = ValueNotifier([]);

  static void addFavorite(Books book) {
    if (!favoriteBooksNotifier.value.contains(book)) {
      favoriteBooksNotifier.value = [...favoriteBooksNotifier.value, book];
    }
  }

  static void removeFavorite(Books book) {
    favoriteBooksNotifier.value =
        favoriteBooksNotifier.value.where((p) => p != book).toList();
  }

  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.pink,))


        ,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favorite List",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.pink,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<Books>>(
        valueListenable: FavoritesScreen.favoriteBooksNotifier,
        builder: (context, favoriteBooks, child) {
          if (favoriteBooks.isEmpty) {
            return const Center(child: Text('No favorites added.'));
          }
          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              final book = favoriteBooks[index];
              return ListTile(
                leading: Image.network(
                  book.volumeInfo!.imageLinks!.thumbnail ?? 'https://via.placeholder.com/150',
                  width: 50,
                  height: 50,
                ),
                title: Text(book.volumeInfo!.title ?? 'Book Title'),
                subtitle: Text('\$${book.saleInfo!.saleability ?? '0.00'}',style: TextStyle(color: Colors.pink),),

                trailing: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart, color: Colors.pink),
                          onPressed: () {
                            CartWidget.addProduct(book);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.black),
                          onPressed: () {
                            FavoritesScreen.removeFavorite(book);
                          },
                        ),
                      ],
                    ),

                  ],
                ),

              );
            },
          );
        },
      ),
    );
  }
}
