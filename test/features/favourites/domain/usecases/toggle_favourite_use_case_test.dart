import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wander_nest/features/favourites/domain/usecases/toggle_favourite_use_case.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockFavouritesRepository mockRepository;
  late ToggleFavouriteUseCase toggleFavouriteUseCase;

  setUp(() {
    mockRepository = MockFavouritesRepository();
    toggleFavouriteUseCase = ToggleFavouriteUseCase(mockRepository);
  });

  group('ToggleFavouriteUseCase', () {
    test('calls repository.toggleFavourite with correct campsite ID', () {
      const id = 'campId1';

      toggleFavouriteUseCase(id);

      verify(mockRepository.toggleFavourite(id)).called(1);
    });
  });
}
