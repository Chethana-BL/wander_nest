import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';

abstract class CampsiteRepository {
  Future<List<Campsite>> fetchCampsites();
}
