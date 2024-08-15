import 'package:book_app/core/network/Service_locator.dart';
import 'package:book_app/core/network/book_service.dart';
import 'package:book_app/features/book_home/data/repo/home_repo.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/manager/all_books/all_books_cubit.dart';
import 'package:book_app/features/book_home/presentation/manager/best_seller_books/best_seller_books_cubit.dart';
import 'package:book_app/features/book_home/presentation/views/book_home_view.dart';
import 'package:book_app/features/book_home/presentation/views/book_navigation_bar.dart';
import 'package:book_app/features/book_splash/presentation/views/Splash_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers:[
      BlocProvider(create: (context)=>AllBooksCubit(getIt.get<Home_repo_imp>())..fetch_allbooks()) ,
      BlocProvider(create: (context)=>BestSellerBooksCubit(getIt.get<Home_repo_imp>())..fetch_best_seller_books(),)
    ]

        , child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash_view()
    ));

  }
}