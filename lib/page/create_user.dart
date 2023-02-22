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
  late TextEditingController _title;
  late TextEditingController _description;
  late TextEditingController _imageLink;
  bool validate = false;

  @override
  void initState() {
    validate = true;
    _title = TextEditingController();
    _description = TextEditingController();
    _imageLink = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _imageLink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uId = ref.watch(userUidProvider);

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
                  controller: _title,
                  decoration: InputDecoration(
                      hintText: "Input Name",
                      errorText: validate ? null : "input can't be empty"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _title.text.isEmpty ? validate = false : validate = true;
                    });

                    try {
                      ref
                          .watch(realtimeDatabaseProvider)
                          .child('orders/$uId')
                          .push()
                          .set({
                        'name': _title.text,
                        'description': _description.text,
                        'imageLink': _imageLink.text
                      }).then((_) => const Text("berhasil tambah data"));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: const Text("Submit")),
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
//       'name': _title.text,
//       'price': 120000,
//     }).then((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Data berhasil ditambahkan')));
//     });
}
