import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  group('test `map` function', () {
    group('should return correct List<T> when using valid data', () {
      test('should return correct List<MockData2> when response is List<MockData2>', () async {
        // arrange
        final validResponse = [
          {
            'mock_data': {
              'uid': 1,
              'email': 'email',
            },
          },
          {
            'mock_data': {
              'uid': 2,
              'email': 'email',
            },
          },
        ];
        const expected = [
          MockData2(
            mockData: MockData(
              id: 1,
              email: 'email',
            ),
          ),
          MockData2(
            mockData: MockData(
              id: 2,
              email: 'email',
            ),
          ),
        ];
        // act
        final result = JsonArrayResponseMapper<MockData2>().map(
          response: validResponse,
          decoder: (json) => MockData2.fromJson(json as Map<String, dynamic>),
        );
        // assert
        expect(result, expected);
      });

      test('should return correct List<MockData> when response is List<MockData>', () {
        // arrange
        final validResponse = [
          {
            'uid': 1,
            'email': 'email',
          },
          {
            'uid': 2,
            'email': 'email',
          },
        ];
        const expected = [
          MockData(
            id: 1,
            email: 'email',
          ),
          MockData(
            id: 2,
            email: 'email',
          ),
        ];
        // act
        final result = JsonArrayResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );
        // assert
        expect(result, expected);
      });

      test('should throw AssertionError when response is null', () {
        expect(
          () => JsonArrayResponseMapper<MockData>().map(
            response: null,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          ),
          throwsAssertionError,
        );
      });

      test('should return empty List<MockData> when response is empty List', () {
        // arrange
        const validResponse = [];
        const expected = <MockData>[];
        // act
        final result = JsonArrayResponseMapper<MockData>().map(
          response: validResponse,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );
        // assert
        expect(result, expected);
      });

      test(
        'should throw RemoteException.invalidSuccessResponseMapperType when response is not JSONArray',
        () {
          // arrange
          const response = {
            'uid': 2,
            'email': 'email',
          };
          // assert
          expect(
            () => JsonArrayResponseMapper<MockData>().map(
              response: response,
              decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
            ),
            throwsA(isA<RemoteException>().having(
              (e) => e.kind,
              'kind',
              RemoteExceptionKind.invalidSuccessResponseMapperType,
            )),
          );
        },
      );
    });
  });
}
