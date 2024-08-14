import 'package:acote_flutter_engineer/repository/home/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String perPage = '20';

final homeFutureProvider = FutureProvider.family.autoDispose((
  ref,
  String page,
) async {
  final repo = ref.watch(homeRepositoryProvider);
  final response = await repo.getUsers(perPage, page);
  return response.data;
});
