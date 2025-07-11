import 'package:wander_nest/features/campsite/data/models/campsite_model.dart';

abstract class CampsiteDataSource {
  Future<List<CampsiteModel>> fetchCampsites();
}
