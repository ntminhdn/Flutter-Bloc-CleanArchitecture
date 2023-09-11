import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  late JsonArrayErrorResponseMapper jsonArrayErrorResponseMapper;

  setUp(() {
    jsonArrayErrorResponseMapper = JsonArrayErrorResponseMapper();
  });

  group('test `map` function', () {
    test('should return correct ServerError when using valid data response', () async {
      // arrange
      final errorResponse = [
        {
          'code': 400,
          'message': 'The request is invalid',
        },
      ];
      const expected = ServerError(
        errors: [
          ServerErrorDetail(
            serverStatusCode: 400,
            message: 'The request is invalid',
          ),
        ],
      );
      // act
      final result = jsonArrayErrorResponseMapper.map(errorResponse);
      // assert
      expect(result, expected);
    });

    test('should return correct ServerError when some JSON keys are incorrect', () async {
      // arrange
      final errorResponse = [
        {
          'code': 400, // correct key
          'error_message': 'The request is invalid', // incorrect key
        },
      ];
      const expected = ServerError(errors: [ServerErrorDetail(serverStatusCode: 400)]);
      // act
      final result = jsonArrayErrorResponseMapper.map(errorResponse);
      // assert
      expect(result, expected);
    });

    test(
      'should throw RemoteException.invalidErrorResponse when all JSON keys are incorrect',
      () async {
        // arrange
        final errorResponse = [
          {
            'er_code': 400, // incorrect key
            'error_message': 'The request is invalid', // incorrect key
          },
        ];
        // assert
        expect(
          () => jsonArrayErrorResponseMapper.map(errorResponse),
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
      final errorResponse = [
        {
          'code': '400',
          'message': true,
        },
      ];
      // assert
      expect(
        () => jsonArrayErrorResponseMapper.map(errorResponse),
        throwsA((e) => e is RemoteException && e.kind == RemoteExceptionKind.decodeError),
      );
    });
  });
}
