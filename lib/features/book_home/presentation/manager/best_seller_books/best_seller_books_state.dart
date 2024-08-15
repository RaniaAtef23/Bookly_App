part of 'best_seller_books_cubit.dart';

@immutable
sealed class BestSellerBooksState {}

final class BestSellerBooksInitial extends BestSellerBooksState {}
final class BestSellerBooksloading extends BestSellerBooksState {}
final class BestSellerBooksSuccess extends BestSellerBooksState {
  final List<Books> books;

  BestSellerBooksSuccess(this.books);

}
final class BestSellerBooksFailure extends BestSellerBooksState {
  final String error;

  BestSellerBooksFailure(this.error);


}
