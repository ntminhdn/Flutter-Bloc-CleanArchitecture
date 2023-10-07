import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test `map` function', () {
    group('should return correct T when using valid data', () {
      test('should return correct MockData2 when response is MockData2', () async {
        // arrange
        final validResponse = {
          'mock_data': {
            'uid': 1,
            'email': 'email',
          },
        };
        const expected = MockData2(
          mockData: MockData(
            id: 1,
            email: 'email',
          ),
        );
        // act
        final result = JsonObjectResponseMapper<MockData2>().map(
          response: validResponse,
          decoder: (json) => MockData2.fromJson(json as Map<String, dynamic>),
        );
        // assert
        expect(result, expected);
      });

      test('should return correct MockData when response is MockData', () {
        // arrange
        final validResponse = {
          'uid': 1,
          'email': 'email',
        };
        const expected = MockData(
          id: 1,
          email: 'email',
        );
        // act
        final result = JsonObjectResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );
        // assert
        expect(result, expected);
      });

      test(
        'should return null when response is not JSONObject',
        () {
          // arrange
          const response = [
            {
              'uid': 2,
              'email': 'email',
            },
          ];

          final result = JsonObjectResponseMapper<MockData>().map(
            response: response,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, null);
        },
      );

      test('should throw AssertionError when response is null', () {
        expect(
          () => JsonObjectResponseMapper<MockData>().map(
            response: null,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          ),
          throwsAssertionError,
        );
      });
    });
  });
}
