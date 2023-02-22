import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learn_firebase_riverpod/models/data_food.dart';

import '../providers/auth_provider.dart';
import '../providers/realtimedatabase_providers.dart';

class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({super.key});

  @override
  ConsumerState<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends ConsumerState<ReadPage> {
  String readData = "This is the valueList";

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
  void streamFetchData() {}

  @override
  void dispose() {
    //_descriptionFoodStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uId = ref.watch(userUidProvider);
    final liveDataOrders = ref.watch(streamFoodProvider(uId));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          liveDataOrders.when(
              data: (data) {
                List<ListTile> valueList = [];
                valueList.addAll(data.map((e) => ListTile(
                      title: Text(e.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          try {
                            ref
                                .watch(realtimeDatabaseProvider)
                                .child('orders/$uId')
                                .child(e.itemId)
                                .remove();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                      ),
                    )));
                return SizedBox(
                  height: 500,
                  child: ListView(
                    children: valueList,
                  ),
                );
              },
              error: (error, stackTrace) =>
                  Text(errorDescription(error.toString())),
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
        ]),
      ),
    );
  }

  String errorDescription(String error) {
    if (error.contains("Null")) {
      return "Data is empty";
    } else {
      return 'Error is happening';
    }
  }
}
