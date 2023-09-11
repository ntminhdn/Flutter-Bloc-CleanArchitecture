import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  group('test `map` function', () {
    group('should return correct DataListResponse<T> when using valid data', () {
      test(
        'should return correct DataListResponse<MockData2> when using valid MockData2 data',
        () async {
          // arrange
          final validResponse = {
            'data': [
              {
                'mock_data': {
                  'uid': 1,
                  'email': 'ntminh@gmail.com',
                },
              },
            ],
          };
          const expected = DataListResponse<MockData2>(
            data: [
              MockData2(
                mockData: MockData(
                  id: 1,
                  email: 'ntminh@gmail.com',
                ),
              ),
            ],
          );
          // act
          final result = DataJsonArrayResponseMapper<MockData2>().map(
            response: validResponse,
            decoder: (json) => MockData2.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, expected);
        },
      );

      test('should return correct DataListResponse<MockData> when using valid MockData data', () {
        // arrange
        final validResponse = {
          'data': [
            {
              'uid': 1,
              'email': 'ntminh@gmail.com',
            },
          ],
        };

        const expected = DataListResponse<MockData>(
          data: [
            MockData(
              id: 1,
              email: 'ntminh@gmail.com',
            ),
          ],
        );

        // act
        final result = DataJsonArrayResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );

        // assert
        expect(result, expected);
      });

      test('should return correct DataListResponse<String> when using valid String data', () {
        // arrange
        final validResponse = {
          'data': ['valid string data'],
        };

        const expected = DataListResponse<String>(
          data: ['valid string data'],
        );

        // act
        final result = DataJsonArrayResponseMapper<String>().map(
          response: validResponse,
          decoder: (json) => json.toString(),
        );

        // assert
        expect(result, expected);
      });

      test('should return correct DataListResponse<int> when using valid int data', () {
        // arrange
        final validResponse = {
          'data': [1],
        };

        const expected = DataListResponse<int>(
          data: [1],
        );

        // act
        final result = DataJsonArrayResponseMapper<int>().map(
          response: validResponse,
          decoder: (json) => json as int,
        );

        // assert
        expect(result, expected);
      });

      test('should return default DataListResponse<MockData> when `data` is null', () {
        // arrange
        final validResponse = {
          'data': null,
        };

        const expected = DataListResponse<MockData>();

        // act
        final result = DataJsonArrayResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );

        // assert
        expect(result, expected);
      });

      test('should throw AssertionError when response is null', () {
        expect(
          () => DataJsonArrayResponseMapper<MockData>().map(
            response: null,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          ),
          throwsAssertionError,
        );
      });
    });

    group(
      'should return correct DataListResponse<MockData> when some or all JSON keys are incorrect',
      () {
        test(
          'should return default DataListResponse<MockData> when response does not have `data` JSON key',
          () async {
            // arrange
            final invalidResponse = {
              'result': [
                {
                  'uid': 1,
                  'email': 'ntminh@gmail.com',
                },
              ],
            };

            const expected = DataListResponse<MockData>();

            // act
            final result = DataJsonArrayResponseMapper<MockData>().map(
              response: invalidResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            );

            // assert
            expect(result, expected);
          },
        );

        test(
          'should return default DataListResponse<MockData> when all JSON keys are incorrect',
          () {
            // arrange
            final invalidResponse = {
              'data': [
                {
                  'uuid': 1, // incorrect key
                  'gmail': 'e@gmail.com', // incorrect key
                },
              ],
            };

            const expected = DataListResponse<MockData>(data: [MockData()]);

            // act
            final result = DataJsonArrayResponseMapper<MockData>().map(
              response: invalidResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            );

            // assert
            expect(result, expected);
          },
        );

        test(
          'should return correct DataListResponse<MockData> when some JSON keys are incorrect',
          () async {
            // arrange
            final validResponse = {
              'data': [
                {
                  'uuid': 1, // incorrect key
                  'email': 'e@gmail.com', // correct key
                },
              ],
            };

            const expected = DataListResponse<MockData>(data: [MockData(email: 'e@gmail.com')]);

            // act
            final result = DataJsonArrayResponseMapper<MockData>().map(
              response: validResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            );

            // assert
            expect(result, expected);
          },
        );
      },
    );

    group('should throw RemoteException.decodeError when using incorrect data type', () {
      test(
        'should throw RemoteException.decodeError when both type of `uid` and type of `email` are incorrect',
        () async {
          // arrange
          final invalidResponse = {
            'data': [
              {
                'uid': false, // incorrect type
                'email': true, // incorrect type
              },
            ],
          };
          // assert
          expect(
            () => DataJsonArrayResponseMapper<MockData>().map(
              response: invalidResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            ),
            throwsA(
              isA<RemoteException>().having(
                (e) => e.kind,
                'kind',
                RemoteExceptionKind.decodeError,
              ),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.decodeError when `data` is JSONObject instead of JSONArray',
        () async {
          // arrange
          final invalidResponse = {
            // incorrect type
            'data': {
              'uid': 1,
              'email': 'ntminh@gmail.com',
            },
          };
          // assert
          expect(
            () => DataJsonArrayResponseMapper<MockData>().map(
              response: invalidResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            ),
            throwsA(
              isA<RemoteException>().having(
                (e) => e.kind,
                'kind',
                RemoteExceptionKind.decodeError,
              ),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.invalidSuccessResponse when using incorrect SuccessResponseMapperType',
        () async {
          // arrange
          // JSON response type is incorrect
          final invalidResponse = [
            {
              'uid': 1,
              'email': 'ntminh@gmail.com',
            },
          ];
          // assert
          expect(
            () => DataJsonArrayResponseMapper<MockData>().map(
              response: invalidResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            ),
            throwsA(
              isA<RemoteException>().having(
                (e) => e.kind,
                'kind',
                RemoteExceptionKind.invalidSuccessResponseMapperType,
              ),
            ),
          );
        },
      );
    });
  });
}
