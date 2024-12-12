import 'package:auth_login/components/custom_button.dart';
import 'package:auth_login/components/custom_form_field.dart';
import 'package:auth_login/components/logo.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Logo(),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Sign Up to Continue Using the App',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'User Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(controller: userName,hint: 'Enter Your User Name',validator: (val){
                    if(val == ''){

                      return 'Can not be Empty';
                    }
                    return null;
                  },),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(controller: email,hint: 'Enter Your Email',validator: (val){
                    if(val == ''){

                      return 'Can not be Empty';
                    }
                    return null;
                  },),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(controller: password,hint: 'Enter Your Password',validator: (val){
                    if(val == ''){

                      return 'Can not be Empty';
                    }
                    return null;
                  },),

                ],
              ),
            ),
            SizedBox(height: 30,),
            CustomButton(text: 'Sign Up',onPressed: () async {
             if(formState.currentState!.validate()){
               try {
                 if (email.text.isEmpty || password.text.isEmpty) {
                   AwesomeDialog(
                     context: context,
                     dialogType: DialogType.error,
                     animType: AnimType.rightSlide,
                     title: 'Error',
                     desc: 'Please fill all fields',
                     btnOkOnPress: () {},
                   ).show();
                   return;
                 }
                 final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                   email: email.text,
                   password: password.text,
                 );
                 AwesomeDialog(
                   context: context,
                   dialogType: DialogType.success,
                   animType: AnimType.rightSlide,
                   title: 'Success',
                   desc: 'Sign Up Successfully',
                   btnOkOnPress: () {
                     FirebaseAuth.instance.currentUser!.sendEmailVerification();
                     Navigator.of(context).pushReplacementNamed('Login');
                   },
                 ).show();

               } on FirebaseAuthException catch (e) {
                 String? errorMessage;
                 if (e.code == 'weak-password') {
                   errorMessage = 'The password provided is too weak.';
                 } else if (e.code == 'email-already-in-use') {
                   errorMessage = 'The account already exists for that email.';
                 }
                 AwesomeDialog(
                   context: context,
                   dialogType: DialogType.error,
                   animType: AnimType.rightSlide,
                   title: 'Error',
                   desc: errorMessage,
                   btnOkOnPress: () {},
                 ).show();

               } catch (e) {
                 AwesomeDialog(
                   context: context,
                   dialogType: DialogType.error,
                   animType: AnimType.rightSlide,
                   title: 'Error',
                   desc: 'Unexpected Error happened',
                   btnOkOnPress: () {},
                 ).show();
                 print(e);
               }
             }

            },),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do have an Account ? ",style: TextStyle(fontSize: 16),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamed('Login');
                }, child: const Text('Login',style: TextStyle(fontSize: 16),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
