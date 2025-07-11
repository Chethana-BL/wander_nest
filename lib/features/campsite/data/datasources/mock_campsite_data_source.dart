import 'package:wander_nest/features/campsite/data/datasources/campsite_data_source.dart';
import 'package:wander_nest/features/campsite/data/models/campsite_model.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';

class MockCampsiteDataSource implements CampsiteDataSource {
  @override
  Future<List<CampsiteModel>> fetchCampsites() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      CampsiteModel(
        id: '1',
        label: 'Alpha Camp',
        isCloseToWater: true,
        isCampFireAllowed: true,
        hostLanguages: ['EN', 'DE'],
        pricePerNight: 50,
        photo: 'photo1.jpg',
        createdAt: DateTime(2023, 1, 1),
        geoLocation: const GeoLocation(lat: 0.0, long: 0.0),
      ),
      CampsiteModel(
        id: '2',
        label: 'Delta Camp',
        isCloseToWater: false,
        isCampFireAllowed: false,
        hostLanguages: ['French'],
        pricePerNight: 30,
        photo: 'photo2.jpg',
        createdAt: DateTime(2023, 2, 1),
        geoLocation: const GeoLocation(lat: 1.0, long: 1.0),
      ),
      CampsiteModel(
        id: '3',
        label: 'Beta Camp',
        isCloseToWater: false,
        isCampFireAllowed: true,
        hostLanguages: ['EN'],
        pricePerNight: 80,
        photo: 'photo3.jpg',
        createdAt: DateTime(2023, 3, 1),
        geoLocation: const GeoLocation(lat: 2.0, long: 2.0),
      ),
    ];
  }
}
