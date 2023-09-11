import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  late JsonObjectErrorResponseMapper jsonObjectErrorResponseMapper;

  setUp(() {
    jsonObjectErrorResponseMapper = JsonObjectErrorResponseMapper();
  });

  group('test `map` function', () {
    test('should return correct ServerError when using valid data response', () async {
      // arrange
      final errorResponse = {
        'error': {
          'status_code': 400,
          'error_code': 'invalid_request',
          'message': 'The request is invalid',
        },
      };
      const expected = ServerError(
        generalServerStatusCode: 400,
        generalServerErrorId: 'invalid_request',
        generalMessage: 'The request is invalid',
      );
      // act
      final result = jsonObjectErrorResponseMapper.map(errorResponse);
      // assert
      expect(result, expected);
    });

    test('should return correct ServerError when some JSON keys are incorrect', () async {
      // arrange
      final errorResponse = {
        'error': {
          'status_code': 400,
          'er_code': 'invalid_request',
          'er_message': 'The request is invalid',
        },
      };
      const expected = ServerError(generalServerStatusCode: 400);
      // act
      final result = jsonObjectErrorResponseMapper.map(errorResponse);
      // assert
      expect(result, expected);
    });

    test(
      'should throw RemoteException.invalidErrorResponse when all JSON keys are incorrect',
      () async {
        // arrange
        final errorResponse = {
          'error': {
            'er_code': 400,
            'er_message': 'The request is invalid',
          },
        };
        // assert
        expect(
          () => jsonObjectErrorResponseMapper.map(errorResponse),
          throwsA(
            isA<RemoteException>().having(
              (e) => e.kind,
              'kind',
              RemoteExceptionKind.invalidErrorResponse,
            ),
          ),
        );
      },
    );

    test('should thow RemoteException.decodeError when using invalid data type', () async {
      // arrange
      final errorResponse = {
        'error': {
          'status_code': '400',
          'error_code': true,
          'message': 1,
        },
      };
      // assert
      expect(
        () => jsonObjectErrorResponseMapper.map(errorResponse),
        throwsA(isA<RemoteException>()),
      );
    });
  });
}
