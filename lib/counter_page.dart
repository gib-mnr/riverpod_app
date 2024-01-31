
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_states.dart';

class CounterPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider.state).state;

    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Text(count.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.state).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
