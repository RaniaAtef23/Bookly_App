import 'package:bloc/bloc.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';
part 'best_seller_books_state.dart';

class BestSellerBooksCubit extends Cubit<BestSellerBooksState> {
  final Home_repo home_repo;
  BestSellerBooksCubit(this.home_repo) : super(BestSellerBooksInitial());
  fetch_best_seller_books()async{
    emit(BestSellerBooksloading());
    var result=await home_repo.fetch_best_seller_books();
    result.fold((ifLeft){
      emit(BestSellerBooksFailure(ifLeft.error));
    },(ifRight){
      emit(BestSellerBooksSuccess(ifRight));
    });
  }
}
