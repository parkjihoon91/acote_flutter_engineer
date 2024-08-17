import 'dart:async';

import 'package:acote_flutter_engineer/model/home/home_model.dart';
import 'package:acote_flutter_engineer/repository/home/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 페이지네이션 다음 페이지 여부 on-true, off-false
final isNextPageProvider = StateProvider<bool>((ref) => false);
// 페이지네이션 끝도달 유무 끝-true, 있을경우-false
final isLastPageProvider = StateProvider<bool>((ref) => false);

final homeAsyncNotifierProvider =
    AsyncNotifierProvider<HomeAsyncNotifier, List<HomeModel>>(
        HomeAsyncNotifier.new);

class HomeAsyncNotifier extends AsyncNotifier<List<HomeModel>> {
  String _headers = '';
  int _page = 1;
  String perPage = '20';

  @override
  FutureOr<List<HomeModel>> build() async {
    state = const AsyncValue.loading();
    final repo = ref.watch(homeRepositoryProvider);
    final response = await repo.getUsers(perPage, '1');
    _headers = response.response.headers['link'].toString() ?? '';
    return response.data;
  }

  updateList() async {
    try {
      ref.read(isNextPageProvider.notifier).update((state) => state = true);
      // 다음 페이지가 있는 경우
      if (isBooleanNextPage()) {
        final repo = ref.watch(homeRepositoryProvider);
        _page++;

        final oldData = state.value;
        final response = await repo.getUsers(perPage, _page.toString());
        oldData?.addAll(response.data);

        ref
            .read(isNextPageProvider.notifier)
            .update((state) => state = false);

        state = AsyncValue.data(oldData ?? []);
        return;
      }

      ref
          .read(isNextPageProvider.notifier)
          .update((state) => state = false);

    } catch (e) {
      ref
          .read(isNextPageProvider.notifier)
          .update((state) => state = false);
    }
  }

  // 다음페이지 체크 함수
  bool isBooleanNextPage() {
    String temp = _headers.split(',')[0];
    String result = temp.split(';')[1].trim();

    // 다음페이지가 있는 경우
    if (result == 'rel="next"') {
      return true;
    }

    ref.read(isNextPageProvider.notifier).update((state) => state = false);
    ref.read(isLastPageProvider.notifier).update((state) => state = true);
    return false;
  }
}
