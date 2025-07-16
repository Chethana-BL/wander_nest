import 'package:wander_nest/features/favourites/domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  final Set<String> _favouriteIds = {};

  @override
  Set<String> getFavouriteIds() => _favouriteIds;

  @override
  bool isFavourite(String campsiteId) => _favouriteIds.contains(campsiteId);

  @override
  void toggleFavourite(String campsiteId) {
    if (_favouriteIds.contains(campsiteId)) {
      _favouriteIds.remove(campsiteId);
    } else {
      _favouriteIds.add(campsiteId);
    }
  }
}
