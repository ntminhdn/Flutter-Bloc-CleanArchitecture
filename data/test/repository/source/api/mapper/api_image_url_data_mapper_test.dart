import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ApiImageUrlDataMapper apiImageUrlDataMapper;

  setUp(() {
    apiImageUrlDataMapper = ApiImageUrlDataMapper();
  });

  group('test `mapToEntity` function', () {
    test('should return correct ImageUrl when using valid ApiImageUrlData', () async {
      // arrange
      const data = ApiImageUrlData(
        origin: 'https://www.google.com',
        sm: 'https://www.google.com',
        md: 'https://www.google.com',
        lg: 'https://www.google.com',
      );

      const expected = ImageUrl(
        origin: 'https://www.google.com',
        sm: 'https://www.google.com',
        md: 'https://www.google.com',
        lg: 'https://www.google.com',
      );

      // act
      final result = apiImageUrlDataMapper.mapToEntity(data);

      // assert
      expect(result, expected);
    });

    test('should return null when ApiImageUrlData is null', () async {
      // arrange
      const ApiImageUrlData? data = null;

      // act
      final result = apiImageUrlDataMapper.mapToEntity(data);

      // assert
      expect(result, const ImageUrl());
    });

    test('should return null when some properties of ApiImageUrlData are null', () async {
      // arrange
      const data = ApiImageUrlData(
        origin: 'https://www.google.com',
        sm: null,
        md: null,
        lg: null,
      );

      // act
      final result = apiImageUrlDataMapper.mapToEntity(data);

      // assert
      expect(result, const ImageUrl(origin: 'https://www.google.com'));
    });
  });
}
