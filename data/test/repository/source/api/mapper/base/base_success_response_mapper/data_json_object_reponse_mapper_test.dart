import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  group('test `map` function', () {
    group('should return correct DataResponse<T> when using valid data', () {
      test(
        'should return correct DataResponse<MockData2> when using valid MockData2 data',
        () async {
          final validResponse = {
            'data': {
              'mock_data': {
                'uid': 1,
                'email': 'a@gmail.com',
              },
            },
          };

          const expected = DataResponse<MockData2>(
            data: MockData2(
              mockData: MockData(
                id: 1,
                email: 'a@gmail.com',
              ),
            ),
          );

          final result = DataJsonObjectResponseMapper<MockData2>().map(
            response: validResponse,
            decoder: (json) => MockData2.fromJson(json as Map<String, dynamic>),
          );

          expect(result, expected);
        },
      );

      test('should return correct DataResponse<MockData> when using valid MockData data', () {
        // arrange
        final validResponse = {
          'data': {
            'uid': 1,
            'email': 'a@gmail.com',
          },
        };

        const expected = DataResponse<MockData>(
          data: MockData(id: 1, email: 'a@gmail.com'),
        );

        final result = DataJsonObjectResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );

        expect(result, expected);
      });

      test('should return correct DataResponse<String> when using valid String data', () {
        // arrange
        final validResponse = {
          'data': 'a',
        };

        const expected = DataResponse<String>(
          data: 'a',
        );

        final result = DataJsonObjectResponseMapper<String>().map(
          response: validResponse,
          decoder: (json) => json as String,
        );

        expect(result, expected);
      });

      test('should return correct DataResponse<int> when using valid int data', () {
        // arrange
        final validResponse = {
          'data': 1,
        };

        const expected = DataResponse<int>(
          data: 1,
        );

        final result = DataJsonObjectResponseMapper<int>().map(
          response: validResponse,
          decoder: (json) => json as int,
        );

        expect(result, expected);
      });

      test('should return default DataResponse<MockData> when `data` is null', () {
        // arrange
        final validResponse = {
          'data': null,
        };

        const expected = DataResponse<MockData>();

        final result = DataJsonObjectResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );

        expect(result, expected);
      });

      test('should throw AssertionError when response is null', () {
        expect(
          () => DataJsonObjectResponseMapper<MockData>().map(
            response: null,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          ),
          throwsAssertionError,
        );
      });
    });

    group(
      'should return correct DataResponse<MockData> when some or all JSON keys are incorrect',
      () {
        test(
          'should return default DataResponse<MockData> when response does not have `data` JSON key',
          () async {
            final invalidResponse = {
              'result': {
                'uid': 1,
                'email': 'a@gmail.com',
              },
            };

            const expected = DataResponse<MockData>();

            final result = DataJsonObjectResponseMapper<MockData>().map(
              response: invalidResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            );

            expect(result, expected);
          },
        );

        test('should return default DataResponse<MockData> when all JSON keys are incorrect', () {
          final invalidResponse = {
            'data': {
              'uuid': 1, // incorrect key
              'gmail': 'a@gmail.com', // incorrect key
            },
          };

          const expected = DataResponse<MockData>(data: MockData());

          final result = DataJsonObjectResponseMapper<MockData>().map(
            response: invalidResponse,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          expect(result, expected);
        });

        test(
          'should return correct DataResponse<MockData> when some JSON keys are incorrect',
          () async {
            // arrange
            final validResponse = {
              'data': {
                'uuid': 1, // incorrect key
                'email': 'e@gmail.com', // correct key
              },
            };

            const expected = DataResponse<MockData>(
              data: MockData(email: 'e@gmail.com'),
            );

            final result = DataJsonObjectResponseMapper<MockData>().map(
              response: validResponse,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            );

            expect(result, expected);
          },
        );
      },
    );

    group('should throw RemoteException.decodeError when using incorrect data type', () {
      test(
        'should throw RemoteException.decodeError when both type of `uid` and type of `email` are incorrect',
        () async {
          final invalidResponse = {
            'data': {
              'uid': '1', // incorrect type
              'email': 1, // incorrect type
            },
          };

          expect(
            () => DataJsonObjectResponseMapper<MockData>().map(
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
        'should throw RemoteException.decodeError when `data` is JSONArray instead of JSONObject',
        () async {
          final invalidResponse = {
            'data': [
              {
                'uid': 1,
                'email': 'a@gmail.com',
              },
            ],
          };

          expect(
            () => DataJsonObjectResponseMapper<MockData>().map(
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
          // JSON response type is incorrect
          final invalidResponse = [
            {
              'uid': 1,
              'email': 'ntminh@gmail.com',
            },
          ];

          expect(
            () => DataJsonObjectResponseMapper<MockData>().map(
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
