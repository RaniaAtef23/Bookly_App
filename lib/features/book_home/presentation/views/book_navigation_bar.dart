import 'package:book_app/features/book_home/presentation/views/Cart_screen.dart';
import 'package:book_app/features/book_home/presentation/views/widgets/Cart_widget.dart';
import 'package:book_app/features/book_home/presentation/views/Favourite_books.dart';
import 'package:book_app/features/book_home/presentation/views/book_home_view.dart';
import 'package:flutter/material.dart';


class Book_navigation_bar extends StatefulWidget {
  const Book_navigation_bar({super.key});

  @override
  State<Book_navigation_bar> createState() => _Book_navigation_barState();
}

class _Book_navigation_barState extends State<Book_navigation_bar> {
  int selected_index=0;
  final List<Widget>pages=[
    BookHomeView(),
    Cart_screen(),
    FavoritesScreen(),


  ];
  void _onItemTapped(int index) {
    setState(() {
      selected_index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selected_index,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: selected_index,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
