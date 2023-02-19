import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/realtimedatabase_providers.dart';

class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({super.key});

  @override
  ConsumerState<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends ConsumerState<ReadPage> {
  String readData = "This is the value";
  late StreamSubscription _descriptionFoodStream;

  @override
  void initState() {
    _descriptionFoodStream = ref
        .read(realtimeDatabaseProvider)
        .child('food/description')
        .onValue
        .listen((event) {
      final Object? description = event.snapshot.value;
      setState(() {
        readData = description.toString();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFoodStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("read data")),
      body: Center(
        child: Column(children: [
          Text(readData),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('back'))
        ]),
      ),
    );
  }
}
