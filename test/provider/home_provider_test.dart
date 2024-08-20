import 'package:acote_flutter_engineer/common/mock/mock_data.dart';
import 'package:acote_flutter_engineer/provider/home/home_provider.dart';
import 'package:acote_flutter_engineer/repository/home/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late ProviderContainer container;
  late HomeRepository homeRepository;

  setUpAll(() {
    container = ProviderContainer();
    homeRepository = MockHomeRepository();
  });

  test('의존성 주입 및 객체 생성 완료', () => expect(homeRepository, isNotNull));

  group('홈 리스트 리스트 api', () {
    test('home api 호출완료', () async {
      try {
        await homeRepository.getUsers('20', '1');
      } catch (e) {
      }
      // 1번 호출되었는지 확인
      verify(() => homeRepository.getUsers(any(), any())).called(1);
    });

    test('home api 호출 실패', () async {
      final exception = Exception('error');
      when(() => homeRepository.getUsers(any(), any())).thenThrow(exception);
      expect(() => homeRepository.getUsers('20', '1'), throwsA(exception));
    });

    test('home api 호출 성공적으로 불러옴', () async {
      addTearDown(container.dispose);

      when(() => homeRepository.getUsers('20', '1'))
          .thenAnswer((_) async => HttpResponse(
              homeListMockData,
              Response(
                requestOptions: RequestOptions(
                    path: 'https://api.github.com/users?per_page=20&page=1'),
                statusCode: 200,
                data: homeListMockData,
              )));

      final actual =
          await container.read(homeAsyncNotifierProvider.notifier).build();
      List<Map<String, dynamic>>? actualList =
          actual.map((model) => model.toJson()).toList();

      final expected = await homeRepository.getUsers('20', '1');
      List<Map<String, dynamic>> expectedList =
          expected.data.map((model) => model.toJson()).toList();

      expect(actualList, expectedList);
    });
  });

}
