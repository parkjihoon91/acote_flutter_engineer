import 'package:acote_flutter_engineer/model/home/home_detail_model.dart';
import 'package:acote_flutter_engineer/repository/home/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeDetailProvider =
    FutureProvider.family.autoDispose<List<HomeDetailModel>, String>((
  ref,
  String username,
) async {
  try {
    final repo = ref.watch(homeRepositoryProvider);
    final response = await repo.getUserDetail(username);
    return response.data;
  } catch (e) {
    return [];
  }
});
