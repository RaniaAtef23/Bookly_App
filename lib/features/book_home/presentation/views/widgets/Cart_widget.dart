import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:flutter/material.dart';
class CartWidget extends StatefulWidget {
  static ValueNotifier<List<Books>> cartBooksNotifier = ValueNotifier([]);

  static void addProduct(Books book) {
    if (!cartBooksNotifier.value.contains(book)) {
      cartBooksNotifier.value = [...cartBooksNotifier.value, book];
    }
  }

  static void removeProduct(Books book) {
    cartBooksNotifier.value =
        cartBooksNotifier.value.where((p) => p != book).toList();
  }

  const CartWidget({super.key});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart Items',
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<Books>>(
              valueListenable: CartWidget.cartBooksNotifier,
              builder: (context, cartBooks, child) {


                if (cartBooks.isEmpty) {
                  return const Center(child: Text('No items in the cart.'));
                }
                return ListView.builder(
                  itemCount: cartBooks.length,
                  itemBuilder: (context, index) {
                    final book = cartBooks[index];
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ListTile(
                            title: Text(
                               "${book.volumeInfo!.title}"?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                            leading: Image.network(
                              book.volumeInfo!.imageLinks!.thumbnail ?? 'assets/erroe.gif',
                              width: 150,
                              height: 150,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, right: 20),
                                child: Text(
                                  "\$${book.saleInfo!.saleability?? '0.00'}",
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    CartWidget.removeProduct(book);
                                  });
                                },
                                color: Colors.pink,
                                child: const Text("Remove", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.pink),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 10),
          MaterialButton(
            color: Colors.pink,
            child: const Text(
              "Order Now",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // Handle order now action
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
