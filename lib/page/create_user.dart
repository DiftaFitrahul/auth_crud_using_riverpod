import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/page/read_user.dart';
import 'package:learn_firebase_riverpod/providers/realtimedatabase_providers.dart';

import '../providers/auth_provider.dart';

class CreateUser extends ConsumerStatefulWidget {
  const CreateUser({super.key});

  @override
  ConsumerState<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends ConsumerState<CreateUser> {
  late TextEditingController _controller1;
  bool validate = false;

  @override
  void initState() {
    validate = true;
    _controller1 = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uId = ref.watch(userUidProvider);
    //final dataFood = ref.watch(realtimeDatabaseProvider).child('/food');

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _controller1,
                  decoration: InputDecoration(
                      hintText: "Input Name",
                      errorText: validate ? null : "input can't be empty"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller1.text.isEmpty
                          ? validate = false
                          : validate = true;
                    });

                    try {
                      ref
                          .watch(realtimeDatabaseProvider)
                          .child('/orders')
                          .push()
                          .set({
                        'name': _controller1.text,
                        'description':
                            'food that very delicious from Yogyakarta',
                        'price': 27000,
                        'user_id': uId
                      }).then((_) => const Text("berhasil tambah data"));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: const Text("Submit")),
              ElevatedButton(
                  onPressed: () {
                    try {
                      ref.read(realtimeDatabaseProvider).update({
                        'food/price': 4000,
                        'food/description': 'food that very delicious',
                        'food/number': 12,
                        'orders/description': 'good'
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('update data')),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReadPage(),
                        ));
                  },
                  child: const Text('go to read page')),
              Text("your id is $uId")
            ],
          ),
        ),
      ),
    );
  }
//  dataFood.set({
//       'name': _controller1.text,
//       'price': 120000,
//     }).then((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Data berhasil ditambahkan')));
//     });
}
