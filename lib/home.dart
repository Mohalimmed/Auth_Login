import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Home Page'),
      actions: [
        IconButton(onPressed: () async{

          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('Login', (route) => false,);
        }, icon: const Icon(Icons.exit_to_app))
      ],
      ),
    );
  }
}
