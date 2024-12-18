import 'package:auth_login/components/custom_button.dart';
import 'package:auth_login/components/custom_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  addCategories() async {
    if (formState.currentState!.validate()) {
      try {
        DocumentReference reference =
            await categories.add({'name': textEditingController.text,
            'id' : FirebaseAuth.instance.currentUser!.uid
            });
        print("category Added");
        Navigator.of(context).pushReplacementNamed('home');
      } catch (e) {
        print('error $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          child: Column(
            children: <Widget>[
              CustomFormField(
                hint: 'Enter Text',
                controller: textEditingController,
                validator: (val) {
                  if (val == '') {
                    return 'Can not be Empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Add',
                onPressed: () {
                  addCategories();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
