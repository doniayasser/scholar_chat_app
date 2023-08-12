import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/shared/components/components.dart';
import 'package:scholar_chat/shared/components/constants.dart';

import 'chat_page.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({Key? key}) : super(key: key);
  static String id="SignUpPage";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? password;

  String? mail;

  bool? isLoading=false;

  GlobalKey<FormState> registerForm=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading!,
      child: Form(
        key: registerForm,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              children: [
                const SizedBox(height: 70,),
                Center(child: Image.asset(kLogo)),
                const Center(
                  child: Text(
                    "Scholar Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 120.0,),
                const Row(
                  children: [
                    Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                TextFieldComponent("Email" ,prefix:const Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ), change:(data){
                  mail=data;
                } ,),
                const SizedBox(height: 15.0,),
                TextFieldComponent("Password" ,prefix:const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),change:(data){
                  password=data;
                } ,
                  obsecurePass:true ,
                  suffix: const Icon(Icons.remove_red_eye_outlined,color: Colors.white,),),
                const SizedBox(height: 35,),
                ButtonComponent(buttonLabel: "Register",
                  tapped: () async{
                  if(registerForm.currentState!.validate())
                    {
                      isLoading=true;
                      setState(() {
                      });
                      try{
                        await userRegister();
                        print("successRegister");
                        snackBar(context, 'successRegister');
                        Navigator.pushNamed(context,ChatScreen.id,arguments: mail);
                      } on FirebaseAuthException catch(err)
                      {
                        print(err.toString());
                        if (err.toString().contains('weak-password')) {
                          snackBar(context, 'The password provided is too weak.');
                        } else if (err.toString().contains('email-already-in-use')) {
                          snackBar(context, 'The account already exists for that email.');
                        }
                        else if (err.toString().contains('invalid-email')) {
                          snackBar(context,"Invalid Email, try again.");
                        }
                      }catch(e){
                        snackBar(context, "Error");};
                      isLoading=false;
                      setState(() {});
                    }

                  },
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, HomeScreen.id);
                    }, child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20.0,
                        color:Color(0xffC7EDE6),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userRegister() async {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:mail! , password: password!);
  }
}




