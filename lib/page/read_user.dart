import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/database/firebase_realtime_database.dart';
import 'package:learn_firebase_riverpod/models/data_food.dart';

import '../providers/realtimedatabase_providers.dart';

class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({super.key});

  @override
  ConsumerState<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends ConsumerState<ReadPage> {
  String readData = "This is the valueList";
  late StreamSubscription _descriptionFoodStream;

  @override
  void initState() {
    //onceFetchData();
    super.initState();
  }

  //only fetch data once
  void onceFetchData() {
    ref.read(realtimeDatabaseProvider).child('/orders').get().then((snapshot) {
      final description = Map<String, dynamic>.from(snapshot.value as Map);
      final dataFood = Food.fromRTDB(description);
      setState(() {
        readData = dataFood.foodDetails;
      });
    });
  }

  // continuing fetch data because its stream
  void streamFetchData() {
    _descriptionFoodStream = ref
        .read(realtimeDatabaseProvider)
        .child('/orders')
        .onValue
        .listen((event) {
      final description =
          Map<String, dynamic>.from(event.snapshot.value as Map);
      final foodData = Food.fromRTDB(description);

      setState(() {
        readData = foodData.foodDetails;
      });
    });
  }

  @override
  void dispose() {
    //_descriptionFoodStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liveDataOrders = ref.watch(streamFoodProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("read data")),
      body: Column(children: [
        liveDataOrders.when(
            data: (data) {
              List<ListTile> valueList = [];
              valueList.addAll(data.map((e) => ListTile(
                    title: Text(e.name),
                  )));
              return SizedBox(
                height: 500,
                child: ListView(
                  children: valueList,
                ),
              );
            },
            error: (error, stackTrace) => Text('error'),
            loading: () => const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                )),

        // StreamBuilder(
        //   stream: RealtimeDatabase(FirebaseDatabase.instance.ref()).fetchData(),
        //   builder: (context, snapshot) {
        //     final tileList = <ListTile>[];
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const CircularProgressIndicator();
        //     } else if (snapshot.hasData) {
        //       List<Food>? data = snapshot.data;
        //       tileList.addAll(data!.map((e) => ListTile(title: Text(e.name))));
        //     }
        //     return SizedBox(
        //       height: 500,
        //       child: ListView(
        //         children: tileList,
        //       ),
        //     );
        //   },
        // ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('back'))
      ]),
    );
  }
}
