import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/favourites/data/repositories/favourites_repository_impl.dart';
import 'package:wander_nest/features/favourites/domain/repositories/favourites_repository.dart';

void main() {
  group('FavouritesRepositoryImpl', () {
    late FavouritesRepository repository;

    setUp(() {
      repository = FavouritesRepositoryImpl();
    });

    test('initial favourites set is empty', () {
      expect(repository.getFavouriteIds(), isEmpty);
    });

    test('toggleFavourite adds an ID if not present', () {
      const id = 'campId1';
      expect(repository.getFavouriteIds(), isEmpty);

      repository.toggleFavourite(id);

      expect(repository.getFavouriteIds(), contains(id));
      expect(repository.isFavourite(id), isTrue);
    });

    test('toggleFavourite removes an ID if already present', () {
      const id = 'campId1';

      repository.toggleFavourite(id); // add
      repository.toggleFavourite(id); // remove

      expect(repository.getFavouriteIds(), isNot(contains(id)));
      expect(repository.isFavourite(id), isFalse);
    });

    test(
      'toggleFavourite handles add and remove when there are multiple favourites',
      () {
        repository.toggleFavourite('campId1');
        repository.toggleFavourite('campId2');

        expect(
          repository.getFavouriteIds(),
          containsAll(['campId1', 'campId2']),
        );
        expect(repository.isFavourite('campId1'), isTrue);

        repository.toggleFavourite('campId1');
        expect(repository.isFavourite('campId1'), isFalse);
      },
    );
  });
}
