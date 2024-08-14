import 'package:acote_flutter_engineer/common/provider/dio_provider.dart';
import 'package:acote_flutter_engineer/model/home/home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'home_repository.g.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return HomeRepository(dio);
});

@RestApi(baseUrl: 'https://api.github.com')
abstract class HomeRepository {
  factory HomeRepository(Dio dio, {String baseUrl}) = _HomeRepository;

  @GET('/users')
  Future<HttpResponse<List<HomeModel>>> getUsers(
    @Query('per_page') String perPage,
    @Query('page') String page,
  );
}
