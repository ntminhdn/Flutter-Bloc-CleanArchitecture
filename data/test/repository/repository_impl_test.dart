import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppApiService extends Mock implements AppApiService {}

class MockAppPreferences extends Mock implements AppPreferences {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockPreferenceUserDataMapper extends Mock implements PreferenceUserDataMapper {}

class MockApiUserDataMapper extends Mock implements ApiUserDataMapper {}

class MockLanguageCodeDataMapper extends Mock implements LanguageCodeDataMapper {}

class MockGenderDataMapper extends Mock implements GenderDataMapper {}

class MockLocalUserDataMapper extends Mock implements LocalUserDataMapper {}

void main() {
  late Repository repository;
  final _mockAppApiService = MockAppApiService();
  final _mockAppPreferences = MockAppPreferences();
  final _mockAppDatabase = MockAppDatabase();
  final _mockPreferenceUserDataMapper = MockPreferenceUserDataMapper();
  final _mockApiUserDataMapper = MockApiUserDataMapper();
  final _mockLanguageCodeDataMapper = MockLanguageCodeDataMapper();
  final _mockGenderDataMapper = MockGenderDataMapper();
  final _mockLocalUserDataMapper = MockLocalUserDataMapper();

  setUp(() {
    repository = RepositoryImpl(
      _mockAppApiService,
      _mockAppPreferences,
      _mockAppDatabase,
      _mockPreferenceUserDataMapper,
      _mockApiUserDataMapper,
      _mockLanguageCodeDataMapper,
      _mockGenderDataMapper,
      _mockLocalUserDataMapper,
    );
  });

  group('test `isLoggedIn` function', () {
    test('should return true when `_appPreferences.isLoggedIn` is true', () async {
      // arrange
      when(() => _mockAppPreferences.isLoggedIn).thenReturn(true);
      // act
      final result = repository.isLoggedIn;
      // assert
      expect(result, true);
    });
  });
}
