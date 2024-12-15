import 'package:auth_login/components/custom_button.dart';
import 'package:auth_login/components/custom_form_field.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

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
              const SizedBox(height: 20,),
              CustomButton(text: 'Add',onPressed: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
