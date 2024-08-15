import 'package:bloc/bloc.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'all_books_state.dart';

class AllBooksCubit extends Cubit<AllBooksState> {
  final Home_repo home_repo;
  AllBooksCubit(this.home_repo) : super(AllBooksInitial());
  fetch_allbooks()async{
    emit(AllBooksLoading());
    var result=await home_repo.fetch_all_books();
    result.fold((ifLeft){
      emit(AllBooksFailure(ifLeft.error));
    },(ifRight){
      emit(AllBooksSuccess(ifRight));
    });

  }
}
