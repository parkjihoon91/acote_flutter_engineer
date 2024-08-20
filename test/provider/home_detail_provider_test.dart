import 'package:acote_flutter_engineer/common/mock/mock_data.dart';
import 'package:acote_flutter_engineer/provider/home/home_detail_provider.dart';
import 'package:acote_flutter_engineer/repository/home/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late ProviderContainer container;
  late HomeRepository homeRepository;

  setUpAll(() {
    container = ProviderContainer();
    homeRepository = MockHomeRepository();
  });

  test('의존성 주입 및 객체 생성 완료', () => expect(homeRepository, isNotNull));

  group('홈 상세 api', () {
    test('home detail api 호출완료', () async {
      try {
        await homeRepository.getUserDetail('mojombo');
      } catch (e) {}
      verify(() => homeRepository.getUserDetail(any())).called(1);
    });

    test('home detail api 호출 실패', () async {
      final exception = Exception('error');
      when(() => homeRepository.getUserDetail(any())).thenThrow(exception);
      expect(() => homeRepository.getUserDetail('mojombo'), throwsA(exception));
    });

    test('home detail api 호출 성공적으로 불러옴', () async {
      addTearDown(container.dispose);

      final actual = await container.read(homeDetailProvider('mojombo').future);
      List<Map<String, dynamic>>? actualList =
          actual.map((model) => model.toJson()).toList();

      List<Map<String, dynamic>> expectedList =
          homeDetailMockData.map((model) => model.toJson()).toList();

      expect(actualList[0], expectedList[0]);
    });
  });
}
