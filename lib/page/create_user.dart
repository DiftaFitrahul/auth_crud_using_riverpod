import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/providers/realtimedatabase_providers.dart';

import '../providers/auth_provider.dart';

class CreateUser extends ConsumerStatefulWidget {
  static const routeName = './create-user';
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
      appBar: AppBar(
        title: const Text("Create User"),
      ),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _description,
                  decoration: InputDecoration(
                      hintText: "Input Description",
                      errorText: validate ? null : "input can't be empty"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _imageLink,
                  decoration: InputDecoration(
                      hintText: "Input Image Link",
                      errorText: validate ? null : "input can't be empty"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _title.text.length <= 3
                          ? validate = false
                          : validate = true;
                    });
                    if (_description.text.length <= 3 ||
                        _title.text.length <= 3 ||
                        _imageLink.text.length <= 3) {
                      return;
                    }

                    try {
                      ref
                          .watch(realtimeDatabaseProvider)
                          .child('orders/$uId')
                          .push()
                          .set({
                        'name': _title.text,
                        'description': _description.text,
                        'imageLink': _imageLink.text
                      }).then((_) {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: const Text("Submit")),
              const SizedBox(
                height: 200,
              ),
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
