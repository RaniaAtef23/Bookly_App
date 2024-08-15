import 'dart:math';

import 'package:book_app/core/network/book_service.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/manager/all_books/all_books_cubit.dart';
import 'package:book_app/features/book_home/presentation/views/Cart_screen.dart';
import 'package:book_app/features/book_home/presentation/views/widgets/Cart_widget.dart';
import 'package:book_app/features/book_home/presentation/views/widgets/book_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Book_details_view extends StatefulWidget {
  Books book;
  Book_details_view(this.book);

  @override
  State<Book_details_view> createState() => _Book_details_viewState();
}

class _Book_details_viewState extends State<Book_details_view> {

  @override
  Widget build(BuildContext context) {

    return
    BlocBuilder<AllBooksCubit,AllBooksState>(builder: (context,state){
      if(state is AllBooksSuccess){
        return  Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){

                CartWidget.addProduct(widget.book );
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));

              }, icon: Icon(Icons.shopping_cart,color: Colors.pink,))
            ],
            leading: Padding(
              padding: const EdgeInsets.only(top: 18, left: 20),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                highlightColor: Colors.pink,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80,top:10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.5), // Shadow color
                          spreadRadius: 6, // Spread radius
                          blurRadius: 13, // Blur radius
                          offset:
                          Offset(0, 3), // Changes the position of the shadow
                        ),
                      ],
                    ),

                    child: Center(
                      child: ClipRRect(
                        child: widget.book.volumeInfo?.imageLinks?.thumbnail != null
                            ? Center(
                          child: Image.network(
                            widget.book.volumeInfo!.imageLinks!.thumbnail!,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 300,
                          ),
                        )
                            : Image.asset(
                          "assets/erroe.gif",
                          width: 200,
                          height: 300,// Fixed typo: "asssets" to "assets"
                          // Adjusted for consistency
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "${widget.book.volumeInfo!.title!.substring(0, min(
                              25, widget.book.volumeInfo!.title!.length))}...",
                          // Show only the first 25 characters
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow
                              .ellipsis, // Handle any overflow
                        ),),
                      Center(
                          child: Text(
                            "${widget.book!.volumeInfo!.authors}",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Container(
                  width: 260,
                  height: 100,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5), // Shadow color
                                spreadRadius: 6, // Spread radius
                                blurRadius: 13, // Blur radius
                                offset:
                                Offset(0, 3), // Changes the position of the shadow
                              ),
                            ],
                            color: Colors.white,

                          ),
                          width: 130,
                          height: 50,
                          child: Center(

                              child: Row(
                                children: [
                                  Text(
                                    "    ${widget.book.saleInfo!.saleability}",
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),

                                ],
                              ))),
                      Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5), // Shadow color
                                spreadRadius: 6, // Spread radius
                                blurRadius: 13, // Blur radius
                                offset:
                                Offset(0, 3), // Changes the position of the shadow
                              ),
                            ],
                            color: Colors.pink,
                          ),
                          width: 130,
                          height: 50,
                          child: Center(
                              child: Text(
                                "Free Preview",
                                style: TextStyle(
                                    color: Colors.white,

                                    fontSize: 18),
                              ))),
                    ],
                  ),
                ),
                Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("You can also like",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 150,

                      child: state.books != null
                          ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.books!.length,
                        itemBuilder: (context, index) {
                          return Book_category(state.books![index]);
                        },
                      )
                          : Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                )
              ],

            ),
          ),
        );
      }
      else if(state is AllBooksFailure){
        return Text("${state.error}");
      }
      else{
        return Center(child: CircularProgressIndicator(),);
      }

    });

  }
}
