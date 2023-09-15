import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test `fromJson` function', () {
    test('should return correct ApiImageUrlData when using correct response', () async {
      // arrange
      final validResponse = {
        'origin': 'https://www.google.com',
        'sm': 'https://www.google.com',
        'md': 'https://www.google.com',
        'lg': 'https://www.google.com',
      };

      const expected = ApiImageUrlData(
        origin: 'https://www.google.com',
        sm: 'https://www.google.com',
        md: 'https://www.google.com',
        lg: 'https://www.google.com',
      );

      // act
      final result = ApiImageUrlData.fromJson(validResponse);

      // assert
      expect(result, expected);
    });
  });
}
