import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wander_nest/features/favourites/presentation/providers/favourites_provider.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  group('FavouritesProvider (StateNotifier)', () {
    late MockFavouritesRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockFavouritesRepository();

      container = ProviderContainer(
        overrides: [
          favouritesRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is loaded from repository', () {
      when(mockRepository.getFavouriteIds()).thenReturn({'campId1', 'campId2'});

      final notifier = FavouritesNotifier(mockRepository);

      expect(notifier.state, {'campId1', 'campId2'});
    });

    test('toggleFavourite adds and removes from favourites', () {
      // Initial state
      when(mockRepository.getFavouriteIds()).thenReturn({'campId1'});
      final notifier = FavouritesNotifier(mockRepository);

      // Simulate toggle (remove)
      when(mockRepository.getFavouriteIds()).thenReturn({});
      notifier.toggleFavourite('campId1');
      expect(notifier.state, isEmpty);

      // Simulate toggle (add again)
      when(mockRepository.getFavouriteIds()).thenReturn({'campId1'});
      notifier.toggleFavourite('campId1');
      expect(notifier.state, {'campId1'});
    });

    test('isFavourite returns correct value', () {
      when(mockRepository.getFavouriteIds()).thenReturn({'campId1', 'campId2'});
      final notifier = FavouritesNotifier(mockRepository);

      expect(notifier.isFavourite('campId1'), true);
      expect(notifier.isFavourite('id3'), false);
    });

    test('toggleFavouriteUseCaseProvider calls repo.toggleFavourite()', () {
      when(mockRepository.toggleFavourite('campId1')).thenAnswer((_) {});
      final useCase = container.read(toggleFavouriteUseCaseProvider);

      useCase('campId1');
      verify(mockRepository.toggleFavourite('campId1')).called(1);
    });

    test('confirm favouritesProvider works via container', () {
      when(mockRepository.getFavouriteIds()).thenReturn({'campId1'});
      final state = container.read(favouritesProvider);

      expect(state, {'campId1'});

      // Toggle and update
      when(mockRepository.getFavouriteIds()).thenReturn({'campId1', 'campId2'});
      // Update notifier state
      container.read(favouritesProvider.notifier).toggleFavourite('campId2');
      expect(
        container.read(favouritesProvider),
        containsAll(['campId1', 'campId2']),
      );
    });
  });
}
