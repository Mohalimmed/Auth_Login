import 'package:auth_login/components/custom_button.dart';
import 'package:auth_login/components/custom_form_field.dart';
import 'package:auth_login/components/logo.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true,automaticallyImplyLeading: false,),
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
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Login to Continue Using the App',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
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
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Login',
              onPressed: () async {
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

                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text
                  );
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Success',
                    desc: 'Login Successful',
                    btnOkOnPress: () {
                      Navigator.of(context).pushReplacementNamed('home');
                    },
                  ).show();

                } on FirebaseAuthException catch (e) {
                  String errorMessage = 'An error occurred';

                  if (e.code == 'user-not-found') {
                    errorMessage = 'No user found for that email';
                  } else if (e.code == 'wrong-password') {
                    errorMessage = 'Wrong password provided for that user';
                  } else if (e.code == 'invalid-email') {
                    errorMessage = 'Invalid email format';
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
                    desc: 'An unexpected error occurred',
                    btnOkOnPress: () {},
                  ).show();
                }
              }
              },
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              onPressed: () {},
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.grey[200],
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Or Login with Google ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Image.asset('assets/images/google.png',width: 30,)
                ],
              ),
            ),
            const SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an Account ? ",style: TextStyle(fontSize: 16),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacementNamed('SignUp');
                }, child: const Text('Register',style: TextStyle(fontSize: 16),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
