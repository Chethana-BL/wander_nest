import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/favourites/data/repositories/favourites_repository_impl.dart';
import 'package:wander_nest/features/favourites/domain/repositories/favourites_repository.dart';
import 'package:wander_nest/features/favourites/domain/usecases/toggle_favourite_use_case.dart';

final favouritesRepositoryProvider = Provider<FavouritesRepository>(
  (ref) => FavouritesRepositoryImpl(),
);

final toggleFavouriteUseCaseProvider = Provider<ToggleFavouriteUseCase>(
  (ref) => ToggleFavouriteUseCase(ref.read(favouritesRepositoryProvider)),
);

final favouritesProvider =
    StateNotifierProvider<FavouritesNotifier, Set<String>>(
      (ref) => FavouritesNotifier(ref.read(favouritesRepositoryProvider)),
    );

class FavouritesNotifier extends StateNotifier<Set<String>> {
  FavouritesNotifier(this.repository) : super(repository.getFavouriteIds());

  final FavouritesRepository repository;

  void toggleFavourite(String id) {
    repository.toggleFavourite(id);
    state = {...repository.getFavouriteIds()}; // trigger a rebuild
  }

  bool isFavourite(String id) => state.contains(id);
}
