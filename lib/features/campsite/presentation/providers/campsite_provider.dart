import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/config/environment_provider.dart';
import 'package:wander_nest/features/campsite/data/datasources/campsite_data_source.dart';
import 'package:wander_nest/features/campsite/data/datasources/campsite_remote_data_source.dart';
import 'package:wander_nest/features/campsite/data/repositories/campsite_repository_impl.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/domain/repositories/campsite_repository.dart';
import 'package:wander_nest/features/campsite/domain/usecases/fetch_campsites.dart';

// Provides the selected data source (remote, mock, etc.)
final campsiteDataSourceProvider = Provider<CampsiteDataSource>((ref) {
  final config = ref.watch(environmentProvider);

  return CampsiteRemoteDataSource(baseUrl: config.fullApiUrl);
  // Later: Replace with MockDataSource when needed
});

// Provides the repository that talks to the data source
final campsiteRepositoryProvider = Provider<CampsiteRepository>((ref) {
  final dataSource = ref.watch(campsiteDataSourceProvider);
  return CampsiteRepositoryImpl(dataSource);
});

// Use case for fetching campsites
final fetchCampsitesUseCaseProvider = Provider<FetchCampsites>((ref) {
  final repository = ref.watch(campsiteRepositoryProvider);
  return FetchCampsites(repository);
});

// Fetches the full list of campsites from the use case
final campsiteListProvider = FutureProvider<List<Campsite>>((ref) async {
  final fetchCampsites = ref.watch(fetchCampsitesUseCaseProvider);
  return fetchCampsites();
});

/// Sorted campsite list (by name)
final sortedCampsiteListProvider = Provider<List<Campsite>>((ref) {
  final asyncValue = ref.watch(campsiteListProvider);

  return asyncValue.maybeWhen(
    data: (list) {
      list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return list;
    },
    orElse: () => [],
  );
});
