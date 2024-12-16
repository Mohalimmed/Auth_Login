import 'package:auth_login/categories/edit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];

  getDate() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, 'addCategory');
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Category'),
          backgroundColor: Colors.blue.shade50,
        ),

        appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'Login',
                      (route) => false,
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: isLoading == true
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade50),
          strokeWidth: 3,
        ),
      )
          : GridView.builder(
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 160),
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                desc: 'What Do You Want ?',
                descTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
                btnCancelText: 'Delete',
                btnOkText: 'Update',
                btnOkOnPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditCategories(
                      id: data[index].id,
                      oldName: data[index]['name'],
                    ),));
                },
                btnCancelOnPress: () async {
                  await FirebaseFirestore.instance
                      .collection('categories')
                      .doc(data[index].id)
                      .delete();
                  Navigator.of(context)
                      .pushReplacementNamed('home');
                },
              )
                  .show();
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 95,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8),
                    Text(
                      data[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue.shade800,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
