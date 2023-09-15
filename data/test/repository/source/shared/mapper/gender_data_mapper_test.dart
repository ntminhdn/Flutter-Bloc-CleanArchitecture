import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenderDataMapper genderDataMapper;

  setUp(() {
    genderDataMapper = GenderDataMapper();
  });

  group('test`mapToEntity` function', () {
    test('should return Gender.male when data is 0', () async {
      expect(genderDataMapper.mapToEntity(0), Gender.male);
    });

    test('should return Gender.female when data is 1', () async {
      expect(genderDataMapper.mapToEntity(1), Gender.female);
    });

    test('should return Gender.other when data is 2', () async {
      expect(genderDataMapper.mapToEntity(2), Gender.other);
    });

    test('should return Gender.unknown when data is -1', () async {
      expect(genderDataMapper.mapToEntity(-1), Gender.unknown);
    });

    test('should return Gender.unknown when data is -2', () async {
      expect(genderDataMapper.mapToEntity(-2), Gender.unknown);
    });
  });

  group('test `mapToData` function', () {
    test('should return 0 when gender is Gender.male', () async {
      expect(genderDataMapper.mapToData(Gender.male), 0);
    });

    test('should return 1 when gender is Gender.female', () async {
      expect(genderDataMapper.mapToData(Gender.female), 1);
    });

    test('should return 2 when gender is Gender.other', () async {
      expect(genderDataMapper.mapToData(Gender.other), 2);
    });

    test('should return -1 when gender is Gender.unknown', () async {
      expect(genderDataMapper.mapToData(Gender.unknown), -1);
    });
  });
}
