import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_firebase_riverpod/providers/realtimedatabase_providers.dart';

import '../models/data_food.dart';
import '../providers/auth_provider.dart';

class UpdateUser extends ConsumerStatefulWidget {
  final Food dataUser;
  const UpdateUser({super.key, required this.dataUser});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateUserState();
}

class _UpdateUserState extends ConsumerState<UpdateUser> {
  late TextEditingController _title;
  late TextEditingController _description;
  late TextEditingController _imageLink;

  bool valid = true;

  @override
  void initState() {
    _title = TextEditingController(text: widget.dataUser.name);
    _description = TextEditingController(text: widget.dataUser.description);
    _imageLink = TextEditingController(text: widget.dataUser.imageLink);
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
        title: const Text('Update User'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _title,
                  decoration: InputDecoration(
                      hintText: 'Input name',
                      errorText: valid ? null : 'Invalid input'),
                ),
                TextField(
                  controller: _description,
                  decoration: InputDecoration(
                      hintText: 'Input name',
                      errorText: valid ? null : 'Invalid input'),
                ),
                TextField(
                  controller: _imageLink,
                  decoration: InputDecoration(
                      hintText: 'Input name',
                      errorText: valid ? null : 'Invalid input'),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_description.text.length <= 3 ||
                          _title.text.length <= 3 ||
                          _imageLink.text.length <= 3) {
                        setState(() {
                          valid = false;
                        });
                        return;
                      } else {
                        setState(() {
                          valid = true;
                        });
                      }
                      ref
                          .watch(realtimeDatabaseProvider)
                          .child('orders/$uId')
                          .child(widget.dataUser.itemId)
                          .update({
                            'name': _title.text,
                            'description': _description.text,
                            'imageLink': _imageLink.text
                          })
                          .then((_) => Navigator.pop(context))
                          .catchError((e) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                          });
                    },
                    child: const Text('Update User'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
