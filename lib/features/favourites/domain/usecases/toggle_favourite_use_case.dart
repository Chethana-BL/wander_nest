import 'package:wander_nest/features/favourites/domain/repositories/favourites_repository.dart';

class ToggleFavouriteUseCase {
  ToggleFavouriteUseCase(this.repository);
  final FavouritesRepository repository;

  void call(String campsiteId) {
    repository.toggleFavourite(campsiteId);
  }
}
