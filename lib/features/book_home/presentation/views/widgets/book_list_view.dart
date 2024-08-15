
import 'package:book_app/core/network/book_service.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/manager/best_seller_books/best_seller_books_cubit.dart';
import 'package:book_app/features/book_home/presentation/views/Book_details_view.dart';
import 'package:book_app/features/book_home/presentation/views/widgets/book_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Book_list_view extends StatefulWidget {
  @override
  State<Book_list_view> createState() => _Book_list_viewState();
}

class _Book_list_viewState extends State<Book_list_view> {
  //List<Books> data=[];

  @override
/*
  void initState(){
    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {
    try {
      // Initialize Dio instance for book_service
      Dio dio = Dio(); // You can customize Dio with options as needed
      var result = await Home_repo_imp(book_service(dio)).fetch_all_books();

      result.fold(
            (failure) {
          // Handle failure case
          print('Failed to fetch data: $failure');
          setState(() {
            // Optionally, handle error state or show a message
            data = []; // Set data to empty list or handle error condition
          });
        },
            (booksList) {
          // Handle success case
          setState(() {
            data = booksList;
          });
        },
      );
    } catch (e) {
      // Handle exceptions, e.g., Dio errors or other unexpected errors
      print('Error fetching data: $e');
      setState(() {
        data = []; // Set data to empty list or handle error condition
      });
    }
  }
*/



  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerBooksCubit, BestSellerBooksState>(
      builder: (context, state) {
        if (state is BestSellerBooksloading) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is BestSellerBooksFailure) {
          return SliverFillRemaining(
            child: Center(child: Text("Error: ${state.error}")),
          );
        } else if (state is BestSellerBooksSuccess) {
          final data = state.books; // Replace with the actual data field from your state

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return InkWell(
                  child: BookTile(data[index]), // Use your BookTile widget
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Book_details_view(data[index]), // Use your BookDetailsView widget
                      ),
                    );
                  },
                );
              },
              childCount: data.length,
            ),
          );
        } else {
          // Handle any other state or default case if necessary
          return SliverFillRemaining(
            child: Center(child: Text("Unknown state")),
          );
        }
      },
    );
  }
}
