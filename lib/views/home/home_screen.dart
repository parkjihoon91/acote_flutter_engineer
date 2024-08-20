import 'package:acote_flutter_engineer/provider/home/home_provider.dart';
import 'package:acote_flutter_engineer/views/home/banner_screen.dart';
import 'package:acote_flutter_engineer/views/home/home_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final String _bannerImage = 'https://placehold.it/500x100?text=ad';

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // 스크롤 감지
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll * 0.9) {
      // throttle 적용
      EasyThrottle.throttle(
        'home_list',
        const Duration(milliseconds: 1500),
            () async {
          ref.read(homeAsyncNotifierProvider.notifier).updateList();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈화면'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(homeAsyncNotifierProvider);
                return state.when(
                  data: (data) {
                    return ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (_, index) {
                        final itemValue = data[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => HomeDetailScreen(
                                  username: itemValue.login,
                                ),
                              ),
                            );
                          },
                          leading: CachedNetworkImage(
                            imageUrl: itemValue.avatarUrl,
                            width: 32,
                            height: 32,
                            errorWidget: (_, url, error) =>
                            const Icon(Icons.error),
                          ),
                          title: Text('name: ${itemValue.login}'),
                        );
                      },
                      separatorBuilder: (_, index) {
                        final bannerIdx = index + 1;
                        if (bannerIdx % 10 == 0) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const BannerScreen(),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: _bannerImage,
                              width: 32,
                              height: 32,
                              alignment: Alignment.centerLeft,
                              placeholder: (_, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (_, url, error) =>
                              const Icon(Icons.error),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      itemCount: data.length,
                    );
                  },
                  error: (error, trace) => Center(
                    child: Text('error: $error'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          Consumer(
            builder: (_, ref, child) {
              final isNextPage = ref.watch(isNextPageProvider);
              return isNextPage
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink();
            },
          ),
          Consumer(
            builder: (_, ref, child) {
              final isLastPage = ref.watch(isLastPageProvider);
              return isLastPage
                  ? const Center(
                child: Text(
                  '더이상 리스트 정보가 없습니다.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}


class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림화면'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('알림화면'),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('탐색화면'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('탐색화면'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필화면'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('프로필화면'),
        ),
      ),
    );
  }
}

