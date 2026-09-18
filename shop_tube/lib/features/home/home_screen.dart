import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_tube/core/api/dio_client.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.watch(dioProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Shop Tube")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Riverpod is working"),
            const SizedBox(height: 30),
            Text('API : ${dio.options.baseUrl}'),
          ],
        ),
      ),
    );
  }
}
