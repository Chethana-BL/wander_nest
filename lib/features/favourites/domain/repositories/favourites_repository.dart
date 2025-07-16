abstract class FavouritesRepository {
  Set<String> getFavouriteIds();
  bool isFavourite(String campsiteId);
  void toggleFavourite(String campsiteId);
}
