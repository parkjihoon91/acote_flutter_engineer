import 'package:acote_flutter_engineer/provider/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈화면'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(homeFutureProvider('1'));
                return state.when(
                  data: (data) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          final itemValue = data[index];
                          return ListTile(
                            onTap: () {},
                            leading: CachedNetworkImage(
                              imageUrl: itemValue.avatarUrl,
                              width: 32,
                              height: 32,
                            ),
                            title: Text('name: ${itemValue.login}'),
                          );
                        },
                        separatorBuilder: (_, index) {
                          final bannerIdx = index + 1;
                          if (bannerIdx % 10 == 0) {
                            return const Text('광고 배너');
                          }
                          return const SizedBox.shrink();
                        },
                        itemCount: 30,
                      ),
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
          ],
        ),
      ),
    );
  }
}
