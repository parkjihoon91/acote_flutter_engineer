import 'package:acote_flutter_engineer/model/home/home_model.dart';
import 'package:acote_flutter_engineer/provider/home/home_detail_provider.dart';
import 'package:acote_flutter_engineer/provider/home/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUpAll(() {
    container = ProviderContainer();
  });

  test('home_provider api', () async {
    addTearDown(container.dispose);

    // 초기값
    expect(container.read(homeAsyncNotifierProvider), isA<AsyncLoading<List<HomeModel>>>());

    await container.read(homeAsyncNotifierProvider.notifier).build();

    expect(container.read(homeAsyncNotifierProvider).value?.length, 20);
    expect(container.read(homeAsyncNotifierProvider).value?.first.login.toString(), 'mojombo');

    // next page
    await container.read(homeAsyncNotifierProvider.notifier).updateList();
    expect(container.read(homeAsyncNotifierProvider).value?.length, 40);
  });

  test('home_detail_provider api', () async {
    addTearDown(container.dispose);

    final result = await container.read(homeDetailProvider('mojombo').future);

    expect(result.first.fullName.toString(), 'mojombo/30daysoflaptops.github.io');

  });

}
