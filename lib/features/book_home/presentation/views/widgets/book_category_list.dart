
import 'dart:math';

import 'package:book_app/core/network/book_service.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/manager/all_books/all_books_cubit.dart';
import 'package:book_app/features/book_home/presentation/views/Book_details_view.dart';
import 'package:book_app/features/book_home/presentation/views/widgets/book_category.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Book_category_list extends StatefulWidget {
  const Book_category_list({super.key});

  @override
  State<Book_category_list> createState() => _Book_category_listState();
}

class _Book_category_listState extends State<Book_category_list> {

  int selectedIndex = -1; // Initialize selectedIndex to -1
  late final book_service service;

  @override

    Widget build(BuildContext context) {


      return BlocBuilder<AllBooksCubit, AllBooksState>(
          builder: (context, state) {
            if(state is AllBooksSuccess){
              return  Stack(
                children: [
                  Positioned(
                    left: -400,
                    right: -400,
                    top: -550,
                    bottom: -30,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(250),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 310,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                        ),
                        itemCount: state.books!.length,
                        itemBuilder: (context, index, realIndex) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Book_details_view(
                                       state.books![index],
                                      ),
                                ),
                              );
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Column(
                              children: [
                                Book_category(state.books![index]),
                                SizedBox(height: 15),
                                Text(
                                  "${ state.books[index].volumeInfo!.title!.substring(0, min(
                                      25,state.books![index].volumeInfo!.title!.length))}...",
                                  // Show only the first 25 characters
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow
                                      .ellipsis, // Handle any overflow
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "Best Seller",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );

            }
            else if(state is AllBooksFailure){
              return Text("error carsoul ");
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
            // return widget here based on BlocA's state
          }
      );

    }
  }
