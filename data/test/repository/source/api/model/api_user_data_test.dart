import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test `fromJson` function', () {
    test('should return correct ApiUserData when using correct response', () async {
      // arrange
      final validResponse = {
        'uid': 100,
        'email': 'ntminh@gmail.com',
        'birthday': '2023-08-12 00:00:00.000',
        'money': '1000000000000',
        'avatar': {
          'origin': 'https://i.imgur.com/BoN9kdC.png',
          'sm': 'https://i.imgur.com/BoN9kdC.png',
          'md': 'https://i.imgur.com/BoN9kdC.png',
          'lg': 'https://i.imgur.com/BoN9kdC.png',
        },
        'photos': [
          {
            'origin': 'https://i.imgur.com/BoN9kdC.png',
            'sm': 'https://i.imgur.com/BoN9kdC.png',
            'md': 'https://i.imgur.com/BoN9kdC.png',
            'lg': 'https://i.imgur.com/BoN9kdC.png',
          },
        ],
        'sex': 1,
      };

      const expected = ApiUserData(
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

      // act
      final result = ApiUserData.fromJson(validResponse);

      // assert
      expect(result, expected);
    });
  });
}
