import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

class MockNoneAuthAppServerApiClient extends Mock implements NoneAuthAppServerApiClient {}

class MockAuthAppServerApiClient extends Mock implements AuthAppServerApiClient {}

class MockRandomUserApiClient extends Mock implements RandomUserApiClient {}

void main() {
  late AppApiService appApiService;
  final _noneAuthAppServerApiClient = MockNoneAuthAppServerApiClient();
  final _authAppServerApiClient = MockAuthAppServerApiClient();
  final _randomUserApiClient = MockRandomUserApiClient();

  setUp(() {
    appApiService = AppApiService(
      _noneAuthAppServerApiClient,
      _authAppServerApiClient,
      _randomUserApiClient,
    );
  });

  group('test `login` function', () {
    test(
      'should return correct DataResponse<ApiAuthResponseData> when using correct response',
      () async {
        when(
          () => _noneAuthAppServerApiClient
              .request<ApiAuthResponseData, DataResponse<ApiAuthResponseData>>(
            method: RestMethod.post,
            path: '/v1/auth/login',
            body: {
              'email': 'inputEmail',
              'password': 'inputPassword',
            },
            decoder: any(named: 'decoder', that: isA<Decoder<ApiAuthResponseData>>()),
          ),
        ).thenAnswer(
          (_) async => const DataResponse(
            data: ApiAuthResponseData(
              accessToken: 'accessToken',
              id: 1,
              name: 'name',
              email: 'email',
              username: 'username',
            ),
          ),
        );

        final result = await appApiService.login(email: 'inputEmail', password: 'inputPassword');

        const expected = DataResponse(
          data: ApiAuthResponseData(
            accessToken: 'accessToken',
            id: 1,
            name: 'name',
            email: 'email',
            username: 'username',
          ),
        );

        expect(result, expected);
      },
    );

    // should return default DataResponse<ApiAuthResponseData> data when response is null
    test(
      'should return null when response is null',
      () async {
        when(
          () => _noneAuthAppServerApiClient
              .request<ApiAuthResponseData, DataResponse<ApiAuthResponseData>>(
            method: RestMethod.post,
            path: '/v1/auth/login',
            body: {
              'email': 'inputEmail',
              'password': 'inputPassword',
            },
            decoder: any(named: 'decoder', that: isA<Decoder<ApiAuthResponseData>>()),
          ),
        ).thenAnswer(
          (_) async => null,
        );

        final result = await appApiService.login(email: 'inputEmail', password: 'inputPassword');

        expect(result, null);
      },
    );
  });

  group('test `getMe` function', () {
    test(
      'should return correct ApiUserData when using correct response',
      () async {
        when(
          () => _authAppServerApiClient.request<ApiUserData, ApiUserData>(
            method: RestMethod.get,
            path: '/v1/me',
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
            decoder: any(named: 'decoder', that: isA<Decoder<ApiUserData>>()),
          ),
        ).thenAnswer(
          (_) async => const ApiUserData(),
        );

        final result = await appApiService.getMe();

        expect(result, const ApiUserData());
      },
    );
  });
}
