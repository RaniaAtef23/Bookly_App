import 'package:book_app/core/network/book_service.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setup() {
 getIt.registerSingleton<book_service>(book_service(Dio()));
 getIt.registerSingleton<Home_repo_imp>(Home_repo_imp(getIt.get<book_service>()));
}