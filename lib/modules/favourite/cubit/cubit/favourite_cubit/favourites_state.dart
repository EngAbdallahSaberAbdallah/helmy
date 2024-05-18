part of 'favourites_cubit.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

final class FavouritesLoading extends FavouritesState {
  final List<FavouriteModel> oldMyDreams;
  final bool isFirstFetch;

  const FavouritesLoading(
      {required this.oldMyDreams, required this.isFirstFetch});
}

final class FavouritesLoaded extends FavouritesState {
  final List<FavouriteModel> favouriteModel;
  const FavouritesLoaded({required this.favouriteModel});

  @override
  List<Object> get props => [favouriteModel];
}

final class FavouritesError extends FavouritesState {
  final Widget exceptionWidget;
  const FavouritesError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}

final class AddFavouriteDreamLoading extends FavouritesState {}

final class AddFavouriteDreamLoaded extends FavouritesState {}

final class AddFavouriteDreamError extends FavouritesState {
  final Widget exceptionWidget;
  const AddFavouriteDreamError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}

final class DeleteFavouriteDreamLoading extends FavouritesState {}

final class DeleteFavouriteDreamLoaded extends FavouritesState {}

final class DeleteFavouriteDreamError extends FavouritesState {
  final Widget exceptionWidget;
  const DeleteFavouriteDreamError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}
