import 'package:mockito/annotations.dart';
import 'package:wander_nest/features/campsite/data/datasources/campsite_remote_data_source.dart';
import 'package:wander_nest/features/campsite/domain/repositories/campsite_repository.dart';
import 'package:wander_nest/features/favourites/domain/repositories/favourites_repository.dart';

@GenerateMocks([
  CampsiteRemoteDataSource,
  CampsiteRepository,
  FavouritesRepository,
])
void main() {}
