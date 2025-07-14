import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/domain/repositories/campsite_repository.dart';

class FetchCampsites {
  FetchCampsites(this.repository);
  final CampsiteRepository repository;

  Future<List<Campsite>> call() {
    return repository.fetchCampsites();
  }
}
