import 'package:auth_login/components/custom_button.dart';
import 'package:auth_login/components/custom_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditCategories extends StatefulWidget {
  final String id;
  final String oldName;
  const EditCategories({super.key, required this.id, required this.oldName});
  @override
  State<EditCategories> createState() => _EditCategoriesState();



}

class _EditCategoriesState extends State<EditCategories> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');

  editCategories() async {
    if (formState.currentState!.validate()) {
      try {
        await categories.doc(widget.id).update({
          'name' : textEditingController.text
        });
        print("category Added");
        Navigator.of(context).pushReplacementNamed('home');
      } catch (e) {
        print('error $e');
      }
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    textEditingController.text = widget.oldName;
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
                  editCategories();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
