import 'dart:io';

import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final _mockDio = MockDio();

  group('test `request` function', () {
    group('test assertions', () {
      test('should throw AssertionError when method is GET and decoder is null', () async {
        // arrange
        const method = RestMethod.get;
        const path = '/v1/auth/login';
        final restApiClient = RestApiClient(
          dio: _mockDio,
          errorResponseMapperType: ErrorResponseMapperType.jsonObject,
          successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        );
        // assert
        expect(
          () async => await restApiClient.request(
            method: method,
            path: path,
          ),
          throwsAssertionError,
        );
      });

      test(
        'should not throw AssertionError when method is GET and decoder is null but `successResponseMapperType` is plain',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.plain,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: 'https://example.com/api'));
          when(
            () => _mockDio.get<dynamic>(
              '/v1/auth/login',
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
            ),
          );

          // assert
          expect(
            () async => await restApiClient.request(
              method: method,
              path: path,
            ),
            returnsNormally,
          );
        },
      );

      test('should not throw AssertionError when method is POST and decoder is null', () async {
        // arrange
        final restApiClient = RestApiClient(
          dio: _mockDio,
          successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        );

        // stub
        when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: 'https://example.com/api'));
        when(
          () => _mockDio.post<dynamic>(
            '/v1/auth/login',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
          ),
        );

        // assert
        expect(
          () async => await restApiClient.request(
            method: RestMethod.post,
            path: '/v1/auth/login',
          ),
          returnsNormally,
        );
      });

      test('should not throw AssertionError when method is PUT and decoder is null', () async {
        // arrange
        final restApiClient = RestApiClient(
          dio: _mockDio,
          successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        );

        // stub
        when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: 'https://example.com/api'));
        when(
          () => _mockDio.put<dynamic>(
            '/v1/auth/login',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
          ),
        );

        // assert
        expect(
          () async => await restApiClient.request(
            method: RestMethod.put,
            path: '/v1/auth/login',
          ),
          returnsNormally,
        );
      });

      test('should not throw AssertionError when method is PATCH and decoder is null', () async {
        // arrange
        final restApiClient = RestApiClient(
          dio: _mockDio,
          successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        );

        // stub
        when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: 'https://example.com/api'));
        when(
          () => _mockDio.patch<dynamic>(
            '/v1/auth/login',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
          ),
        );

        // assert
        expect(
          () async => await restApiClient.request(
            method: RestMethod.patch,
            path: '/v1/auth/login',
          ),
          returnsNormally,
        );
      });

      test('should not throw AssertionError when method is DELETE and decoder is null', () async {
        // arrange
        final restApiClient = RestApiClient(
          dio: _mockDio,
          successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        );

        // stub
        when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: 'https://example.com/api'));
        when(
          () => _mockDio.delete<dynamic>(
            '/v1/auth/login',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
          ),
        );

        // assert
        expect(
          () async => await restApiClient.request(
            method: RestMethod.delete,
            path: '/v1/auth/login',
          ),
          returnsNormally,
        );
      });
    });

    group('test GET method', () {
      test(
        'should return correct DataListResponse<MockData> when API return valid MockData response',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final options = Options(
            headers: {'user-agent': 'android'},
            contentType: 'application/json',
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          );
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
          );

          const response = {
            'data': [
              {'uid': 1, 'email': 'name1'},
              {'uid': 2, 'email': 'name2'},
            ],
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              queryParameters: {'page': 1},
              data: {'email': 'email'},
              options: any(
                named: 'options',
                that: predicate(
                  (options) =>
                      options is Options &&
                      options.headers == options.headers &&
                      options.sendTimeout == options.sendTimeout &&
                      options.receiveTimeout == options.receiveTimeout &&
                      options.contentType == options.contentType &&
                      options.responseType == options.responseType,
                ),
              ),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            queryParameters: {'page': 1},
            body: {'email': 'email'},
            options: options,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = DataListResponse(data: [
            MockData(id: 1, email: 'name1'),
            MockData(id: 2, email: 'name2'),
          ]);

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return correct DataListResponse<String> when API return valid String response',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
          );

          const response = {
            'data': ['name1', 'name2'],
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => json as String,
          );

          const expected = DataListResponse(data: ['name1', 'name2']);

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return correct DataResponse<MockData> when API return valid MockData response',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
          );

          const response = {
            'data': {'uid': 1, 'email': 'name1'},
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = DataResponse(data: MockData(id: 1, email: 'name1'));

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return correct DataResponse<String> when API return valid String response',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
          );

          const response = {
            'data': 'name1',
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => json as String,
          );

          const expected = DataResponse(data: 'name1');

          // assert
          expect(result, expected);
        },
      );

      test('should return correct MockData when API return valid MockData response', () async {
        // arrange
        const method = RestMethod.get;
        const path = '/v1/auth/login';
        const baseUrl = 'https://example.com/api';
        final restApiClient = RestApiClient(
          dio: _mockDio,
          errorResponseMapperType: ErrorResponseMapperType.jsonObject,
          successResponseMapperType: SuccessResponseMapperType.jsonObject,
        );

        const response = {'uid': 1, 'email': 'name1'};

        // stub
        when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
        when(
          () => _mockDio.get<dynamic>(
            path,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response<dynamic>(
            data: response,
            requestOptions: RequestOptions(),
          ),
        );

        // act
        final result = await restApiClient.request(
          method: method,
          path: path,
          decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
        );

        const expected = MockData(id: 1, email: 'name1');

        // assert
        expect(result, expected);
      });

      test(
        'should return null when using `jsonObject` SuccessResponseMapperType and response is null',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = null;

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, null);
        },
      );

      test(
        'should return null when using `plain` SuccessResponseMapperType and response is null',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.plain,
          );

          const response = null;

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, null);
        },
      );

      test(
        'should return null when using `jsonArray` SuccessResponseMapperType and response is null',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonArray,
          );

          const response = null;

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, null);
        },
      );

      test(
        'should return null when using `dataJsonObject` SuccessResponseMapperType and response is null',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
          );

          const response = null;

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, null);
        },
      );

      test(
        'should return null when using `dataJsonArray` SuccessResponseMapperType and response is null',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
          );

          const response = null;

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(result, null);
        },
      );

      test(
        'should return correct List<MockData> when API return valid List<MockData> response',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonArray,
          );

          const response = [
            {'uid': 1, 'email': 'name1'},
            {'uid': 2, 'email': 'name2'},
          ];

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = [
            MockData(id: 1, email: 'name1'),
            MockData(id: 2, email: 'name2'),
          ];

          // assert
          expect(result, expected);
        },
      );

      test('should return correct String when API return valid String response', () async {
        // arrange
        const method = RestMethod.get;
        const path = '/v1/auth/login';
        const baseUrl = 'https://example.com/api';
        final restApiClient = RestApiClient(
          dio: _mockDio,
          errorResponseMapperType: ErrorResponseMapperType.jsonObject,
          successResponseMapperType: SuccessResponseMapperType.plain,
        );

        const response = 'name1';

        // stub
        when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
        when(
          () => _mockDio.get<dynamic>(
            path,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response<dynamic>(
            data: response,
            requestOptions: RequestOptions(),
          ),
        );

        // act
        final result = await restApiClient.request(
          method: method,
          path: path,
        );

        const expected = 'name1';

        // assert
        expect(result, expected);
      });

      test(
        'should return correct DataListResponse<String> when API return empty response',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.plain,
          );

          const response = '';

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
          );

          const expected = '';

          // assert
          expect(result, expected);
        },
      );

      test(
        'should not throw any errors when `path` contains `baseUrl`',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = 'https://example.com/api/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.plain,
          );

          const response = '';

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              '/v1/auth/login',
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
          );

          const expected = '';

          // assert
          expect(result, expected);
        },
      );
    });

    group('test POST method', () {
      test(
        'should return correct MockData when API return valid MockData response',
        () async {
          // arrange
          const method = RestMethod.post;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final options = Options(
            headers: {'user-agent': 'android'},
            contentType: 'application/json',
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          );
          final restApiClient = RestApiClient(
            dio: _mockDio,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = {'uid': 1, 'email': 'name1'};

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.post<dynamic>(
              path,
              queryParameters: const {'page': 1},
              data: {'email': 'email'},
              options: any(
                named: 'options',
                that: predicate(
                  (options) =>
                      options is Options &&
                      options.headers == options.headers &&
                      options.sendTimeout == options.sendTimeout &&
                      options.receiveTimeout == options.receiveTimeout &&
                      options.contentType == options.contentType &&
                      options.responseType == options.responseType,
                ),
              ),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            queryParameters: {'page': 1},
            body: {'email': 'email'},
            options: options,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = MockData(id: 1, email: 'name1');

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return null when API response is null',
        () async {
          // arrange
          const method = RestMethod.post;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.post<dynamic>(
              path,
              data: {'email': 'email'},
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            body: {'email': 'email'},
          );

          expect(result, null);
        },
      );
    });

    group('test PUT method', () {
      test(
        'should return correct MockData when API return valid MockData response',
        () async {
          // arrange
          const method = RestMethod.put;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final options = Options(
            headers: {'user-agent': 'android'},
            contentType: 'application/json',
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          );
          final restApiClient = RestApiClient(
            dio: _mockDio,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = {'uid': 1, 'email': 'name1'};

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.put<dynamic>(
              path,
              queryParameters: {'page': 1},
              data: {'email': 'email'},
              options: any(
                named: 'options',
                that: predicate(
                  (options) =>
                      options is Options &&
                      options.headers == options.headers &&
                      options.sendTimeout == options.sendTimeout &&
                      options.receiveTimeout == options.receiveTimeout &&
                      options.contentType == options.contentType &&
                      options.responseType == options.responseType,
                ),
              ),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            queryParameters: {'page': 1},
            body: {'email': 'email'},
            options: options,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = MockData(id: 1, email: 'name1');

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return null when API response is null',
        () async {
          // arrange
          const method = RestMethod.put;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.put<dynamic>(
              path,
              data: {'email': 'email'},
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            body: {'email': 'email'},
          );

          expect(result, null);
        },
      );
    });

    group('test PATCH method', () {
      test(
        'should return correct MockData when API return valid MockData response',
        () async {
          // arrange
          const method = RestMethod.patch;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final options = Options(
            headers: {'user-agent': 'android'},
            contentType: 'application/json',
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          );
          final restApiClient = RestApiClient(
            dio: _mockDio,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = {'uid': 1, 'email': 'name1'};

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.patch<dynamic>(
              path,
              queryParameters: {'page': 1},
              data: {'email': 'email'},
              options: any(
                named: 'options',
                that: predicate(
                  (options) =>
                      options is Options &&
                      options.headers == options.headers &&
                      options.sendTimeout == options.sendTimeout &&
                      options.receiveTimeout == options.receiveTimeout &&
                      options.contentType == options.contentType &&
                      options.responseType == options.responseType,
                ),
              ),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            queryParameters: {'page': 1},
            body: {'email': 'email'},
            options: options,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = MockData(id: 1, email: 'name1');

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return null when API response is null',
        () async {
          // arrange
          const method = RestMethod.patch;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.patch<dynamic>(
              path,
              data: {'email': 'email'},
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            body: {'email': 'email'},
          );

          expect(result, null);
        },
      );
    });

    group('test DELETE method', () {
      test(
        'should return correct MockData when API return valid MockData response',
        () async {
          // arrange
          const method = RestMethod.delete;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final options = Options(
            headers: {'user-agent': 'android'},
            contentType: 'application/json',
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          );
          final restApiClient = RestApiClient(
            dio: _mockDio,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = {'uid': 1, 'email': 'name1'};

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.delete<dynamic>(
              path,
              queryParameters: {'page': 1},
              data: {'email': 'email'},
              options: any(
                named: 'options',
                that: predicate(
                  (options) =>
                      options is Options &&
                      options.headers == options.headers &&
                      options.sendTimeout == options.sendTimeout &&
                      options.receiveTimeout == options.receiveTimeout &&
                      options.contentType == options.contentType &&
                      options.responseType == options.responseType,
                ),
              ),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            queryParameters: {'page': 1},
            body: {'email': 'email'},
            options: options,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          const expected = MockData(id: 1, email: 'name1');

          // assert
          expect(result, expected);
        },
      );

      test(
        'should return null when API response is null',
        () async {
          // arrange
          const method = RestMethod.delete;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.delete<dynamic>(
              path,
              data: {'email': 'email'},
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response<dynamic>(
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final result = await restApiClient.request(
            method: method,
            path: path,
            body: {'email': 'email'},
          );

          expect(result, null);
        },
      );
    });

    group('test error cases', () {
      test(
        'should throw RemoteException.badCertificate when API throw DioException.badCertificate',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.badCertificate,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>()
                  .having((e) => e.kind, 'kind', RemoteExceptionKind.badCertificate),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.cancel when API throw DioException.cancel',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.cancel,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>()
                  .having((e) => e.kind, 'kind', RemoteExceptionKind.cancellation),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.timeout when API throw DioException.connectionTimeout',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.connectionTimeout,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.timeout),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.timeout when API throw DioException.receiveTimeout',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.receiveTimeout,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.timeout),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.timeout when API throw DioException.sendTimeout',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.sendTimeout,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.timeout),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.unknown when API throw DioException.unknown',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.unknown,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.unknown),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.noInternet when API throw DioException.unknown with `error` is RemoteException.noInternet',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.unknown,
              requestOptions: RequestOptions(),
              error: const RemoteException(kind: RemoteExceptionKind.noInternet),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.noInternet),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.network when API throw DioException.connectionError',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.connectionError,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.network),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.network when API throw DioException.unknown with `error` is SocketException',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.unknown,
              requestOptions: RequestOptions(),
              error: const SocketException(''),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having((e) => e.kind, 'kind', RemoteExceptionKind.network),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.refreshTokenFailed when API throw DioException.unknown with `error` is RemoteException.refreshTokenFailed',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.unknown,
              requestOptions: RequestOptions(),
              error: const RemoteException(kind: RemoteExceptionKind.refreshTokenFailed),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having(
                (e) => e.kind,
                'kind',
                RemoteExceptionKind.refreshTokenFailed,
              ),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.invalidSuccessResponseMapperType when API return invalid JSON',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = 'string';

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
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

      test(
        'should throw RemoteException.decodeError when API return success response with incorrect data type',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          const response = <String, dynamic>{
            'uid': true, // incorrect data type
            'email': false, // incorrect data type
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              data: response,
              requestOptions: RequestOptions(),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
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
        'should throw RemoteException.serverDefined when API throw DioException.badResponse with response is JSONObject',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          final errorResponse = {
            'error': {
              'status_code': 400,
              'error_code': 'err_001',
              'message': 'The request is invalid',
            },
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: RequestOptions(),
              response: Response(
                data: errorResponse,
                statusCode: 400,
                requestOptions: RequestOptions(),
              ),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>()
                  .having(
                    (e) => e.kind,
                    'kind',
                    RemoteExceptionKind.serverDefined,
                  )
                  .having(
                    (e) => e.httpErrorCode,
                    'httpErrorCode',
                    400,
                  )
                  .having(
                    (e) => e.generalServerStatusCode,
                    'generalServerStatusCode',
                    400,
                  )
                  .having(
                    (e) => e.generalServerErrorId,
                    'generalServerErrorId',
                    'err_001',
                  )
                  .having(
                    (e) => e.generalServerMessage,
                    'generalServerMessage',
                    'The request is invalid',
                  )
                  .having(
                    (e) => e.serverError?.generalServerStatusCode,
                    'serverError?.generalServerStatusCode',
                    400,
                  )
                  .having(
                    (e) => e.serverError?.generalServerErrorId,
                    'serverError?.generalServerErrorId',
                    'err_001',
                  )
                  .having(
                    (e) => e.serverError?.generalMessage,
                    'serverError?.generalMessage',
                    'The request is invalid',
                  ),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.serverDefined when API throw DioException.badResponse with response is JSONArray',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonArray,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          final errorResponse = [
            {
              'code': 403,
              'message': 'The request is invalid',
            },
          ];

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: RequestOptions(),
              response: Response(
                data: errorResponse,
                statusCode: 422,
                requestOptions: RequestOptions(),
              ),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>()
                  .having(
                    (e) => e.kind,
                    'kind',
                    RemoteExceptionKind.serverDefined,
                  )
                  .having(
                    (e) => e.httpErrorCode,
                    'httpErrorCode',
                    422,
                  )
                  .having(
                    (e) => e.generalServerStatusCode,
                    'generalServerStatusCode',
                    403,
                  )
                  .having(
                    (e) => e.generalServerErrorId,
                    'generalServerErrorId',
                    null,
                  )
                  .having(
                    (e) => e.generalServerMessage,
                    'generalServerMessage',
                    'The request is invalid',
                  )
                  .having(
                    (e) => e.serverError?.errors,
                    'serverError?.errors',
                    [
                      const ServerErrorDetail(
                        serverStatusCode: 403,
                        message: 'The request is invalid',
                      ),
                    ],
                  )
                  .having(
                    (e) => e.serverError?.generalServerStatusCode,
                    'serverError?.generalServerStatusCode',
                    null,
                  )
                  .having(
                    (e) => e.serverError?.generalServerErrorId,
                    'serverError?.generalServerErrorId',
                    null,
                  )
                  .having(
                    (e) => e.serverError?.generalMessage,
                    'serverError?.generalMessage',
                    null,
                  ),
            ),
          );
        },
      );

      test(
        'should throw RemoteException.serverUndefined when API throw DioException.badResponse with `response.data` is null',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: RequestOptions(),
              response: Response(
                data: null,
                statusCode: 500,
                requestOptions: RequestOptions(),
              ),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>()
                  .having(
                    (e) => e.kind,
                    'kind',
                    RemoteExceptionKind.serverUndefined,
                  )
                  .having(
                    (e) => e.httpErrorCode,
                    'httpErrorCode',
                    500,
                  ),
            ),
          );
        },
      );

      // should throw RemoteException.decodeError when API return error response with incorrect data type
      test(
        'should throw RemoteException.decodeError when API return error response with incorrect data type',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonObject,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          final errorResponse = {
            'error': {
              'status_code': true,
              'error_code': false,
            },
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: RequestOptions(),
              response: Response(
                data: errorResponse,
                requestOptions: RequestOptions(),
              ),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
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

      // should throw RemoteException.decodeError when using incorrect errorResponseMapperType
      test(
        'should throw RemoteException.decodeError when using incorrect errorResponseMapperType',
        () async {
          // arrange
          const method = RestMethod.get;
          const path = '/v1/auth/login';
          const baseUrl = 'https://example.com/api';
          final restApiClient = RestApiClient(
            dio: _mockDio,
            errorResponseMapperType: ErrorResponseMapperType.jsonArray,
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
          );

          final errorResponse = {
            'error': {
              'status_code': 400,
              'error_code': 'err_001',
              'message': 'The request is invalid',
            },
          };

          // stub
          when(() => _mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
          when(
            () => _mockDio.get<dynamic>(
              path,
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: RequestOptions(),
              response: Response(
                data: errorResponse,
                requestOptions: RequestOptions(),
              ),
            ),
          );

          // act
          final call = restApiClient.request(
            method: method,
            path: path,
            decoder: (json) => MockData.fromJson(json as Map<String, dynamic>),
          );

          // assert
          expect(
            call,
            throwsA(
              isA<RemoteException>().having(
                (e) => e.kind,
                'kind',
                RemoteExceptionKind.invalidErrorResponseMapperType,
              ),
            ),
          );
        },
      );
    });
  });
}
