import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/src/model/big_decimal.dart';

class MockGenderDataMapper extends Mock implements GenderDataMapper {}

class MockApiImageUrlDataMapper extends Mock implements ApiImageUrlDataMapper {}

void main() {
  late ApiUserDataMapper apiUserDataMapper;
  final _mockGenderDataMapper = MockGenderDataMapper();
  final _mockApiImageUrlDataMapper = MockApiImageUrlDataMapper();

  setUp(() {
    apiUserDataMapper = ApiUserDataMapper(_mockGenderDataMapper, _mockApiImageUrlDataMapper);
  });

  group('test `mapToEntity` function', () {
    test('should return correct User when using valid ApiUserData', () async {
      // arrange
      const data = ApiUserData(
        id: 100,
        email: 'ntminh@gmail.com',
        birthday: '2023-08-12 00:00:00.000',
        money: '1000000000000',
        avatar: ApiImageUrlData(
          origin: 'https://i.imgur.com/BoN9kdC.png',
          sm: 'https://i.imgur.com/BoN9kdC.png',
          md: 'https://i.imgur.com/BoN9kdC.png',
          lg: 'https://i.imgur.com/BoN9kdC.png',
        ),
        photos: [
          ApiImageUrlData(
            origin: 'https://i.imgur.com/BoN9kdC.png',
            sm: 'https://i.imgur.com/BoN9kdC.png',
            md: 'https://i.imgur.com/BoN9kdC.png',
            lg: 'https://i.imgur.com/BoN9kdC.png',
          ),
        ],
        gender: 1,
      );

      // stub
      when(
        () => _mockApiImageUrlDataMapper.mapToEntity(
          const ApiImageUrlData(
            origin: 'https://i.imgur.com/BoN9kdC.png',
            sm: 'https://i.imgur.com/BoN9kdC.png',
            md: 'https://i.imgur.com/BoN9kdC.png',
            lg: 'https://i.imgur.com/BoN9kdC.png',
          ),
        ),
      ).thenReturn(
        const ImageUrl(
          origin: 'https://i.imgur.com/BoN9kdC.png',
          sm: 'https://i.imgur.com/BoN9kdC.png',
          md: 'https://i.imgur.com/BoN9kdC.png',
          lg: 'https://i.imgur.com/BoN9kdC.png',
        ),
      );

      when(
        () => _mockApiImageUrlDataMapper.mapToListEntity(
          [
            const ApiImageUrlData(
              origin: 'https://i.imgur.com/BoN9kdC.png',
              sm: 'https://i.imgur.com/BoN9kdC.png',
              md: 'https://i.imgur.com/BoN9kdC.png',
              lg: 'https://i.imgur.com/BoN9kdC.png',
            ),
          ],
        ),
      ).thenReturn(
        [
          const ImageUrl(
            origin: 'https://i.imgur.com/BoN9kdC.png',
            sm: 'https://i.imgur.com/BoN9kdC.png',
            md: 'https://i.imgur.com/BoN9kdC.png',
            lg: 'https://i.imgur.com/BoN9kdC.png',
          ),
        ],
      );

      when(() => _mockGenderDataMapper.mapToEntity(1)).thenReturn(Gender.female);

      final expected = User(
        id: 100,
        email: 'ntminh@gmail.com',
        birthday: DateTime(2023, 08, 12),
        money: BigDecimal.parse('1000000000000'),
        avatar: const ImageUrl(
          origin: 'https://i.imgur.com/BoN9kdC.png',
          sm: 'https://i.imgur.com/BoN9kdC.png',
          md: 'https://i.imgur.com/BoN9kdC.png',
          lg: 'https://i.imgur.com/BoN9kdC.png',
        ),
        photos: const [
          ImageUrl(
            origin: 'https://i.imgur.com/BoN9kdC.png',
            sm: 'https://i.imgur.com/BoN9kdC.png',
            md: 'https://i.imgur.com/BoN9kdC.png',
            lg: 'https://i.imgur.com/BoN9kdC.png',
          ),
        ],
        gender: Gender.female,
      );

      // act
      final result = apiUserDataMapper.mapToEntity(data);

      // assert
      expect(result, expected);
    });

    test('should return null when ApiUserData is null', () async {
      // arrange
      const ApiUserData? data = null;

      // stub
      when(() => _mockApiImageUrlDataMapper.mapToEntity(null)).thenReturn(const ImageUrl());
      when(() => _mockApiImageUrlDataMapper.mapToListEntity(null)).thenReturn([]);
      when(() => _mockGenderDataMapper.mapToEntity(null)).thenReturn(Gender.unknown);

      // act
      final result = apiUserDataMapper.mapToEntity(data);

      // assert
      expect(result, const User());
    });

    test('should return null when some properties of ApiUserData are null', () async {
      // arrange
      const data = ApiUserData(
        id: 100,
        email: 'ntminh@gmail.com',
        birthday: '2023-08-12 00:00:00.000',
        money: '1000000000000',
      );

      // stub
      when(() => _mockApiImageUrlDataMapper.mapToEntity(null)).thenReturn(const ImageUrl());
      when(() => _mockApiImageUrlDataMapper.mapToListEntity(null)).thenReturn([]);
      when(() => _mockGenderDataMapper.mapToEntity(null)).thenReturn(Gender.unknown);

      // act
      final result = apiUserDataMapper.mapToEntity(data);

      // assert
      expect(
        result,
        User(
          id: 100,
          email: 'ntminh@gmail.com',
          birthday: DateTime(2023, 08, 12),
          money: BigDecimal.parse('1000000000000'),
        ),
      );
    });
  });
}
