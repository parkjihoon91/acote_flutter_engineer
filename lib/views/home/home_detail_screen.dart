import 'package:acote_flutter_engineer/provider/home/home_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDetailScreen extends ConsumerWidget {
  final String username;

  const HomeDetailScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeDetailProvider(username));
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('상세화면'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: state.when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        final itemValue = data[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '이름: ${itemValue.fullName}',
                              style: textStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                               '설명: ${itemValue.description ?? '없습니다.'}',
                              style: textStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              '별 수: ${itemValue.stargazersCount}',
                              style: textStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              '사용 언어: ${itemValue.language ?? '없습니다.'}',
                              style: textStyle,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: data.length,
                    ),
                  );
                },
                error: (error, trace) => Center(
                  child: Text('error: $error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
