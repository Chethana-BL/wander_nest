import 'package:wander_nest/features/campsite/data/datasources/campsite_data_source.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/domain/repositories/campsite_repository.dart';

class CampsiteRepositoryImpl implements CampsiteRepository {
  CampsiteRepositoryImpl(this.dataSource);
  final CampsiteDataSource dataSource;

  @override
  Future<List<Campsite>> fetchCampsites() async {
    final models = await dataSource.fetchCampsites();
    return models.map((m) => Campsite.fromModel(m)).toList();
  }
}
