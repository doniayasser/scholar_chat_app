import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/shared/components/components.dart';
import 'package:scholar_chat/shared/components/constants.dart';

import 'chat_page.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  static String id="SignInPage";
  String? password;
  String? mail;
  GlobalKey<FormState> loginFormKey=GlobalKey();
  bool? isLoading=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: ModalProgressHUD(
          inAsyncCall: isLoading!,
          child: Form(
            key: loginFormKey,
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
                      "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                TextFieldComponent(
                  "Email" ,
                  prefix:Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                  change:(data){
                  mail=data;
                  } , ),
                const SizedBox(height: 15.0,),
                TextFieldComponent("Password" ,prefix:Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                  change:(data){
                  password=data;
                } ,
                  obsecurePass:true ,
                  suffix: const Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),

                ),
                const SizedBox(height: 35,),
               ButtonComponent(
                 buttonLabel: "Sign In",
                 tapped: () async{
                 if(loginFormKey.currentState!.validate())
                   {
                     isLoading=true;
                     try{
                       await userLogin();
                       Navigator.pushNamed(context,ChatScreen.id,arguments: mail);
                     } on FirebaseAuthException catch(err){
                       if (err.toString().contains('user-not-found')) {
                         snackBar(context,"No user found for that email.");
                       }
                       else if (err.toString().contains('wrong-password')) {
                         snackBar(context,"Wrong password.");
                       }
                       else if (err.toString().contains('invalid-email')) {
                         snackBar(context,"Invalid Email, try again.");
                       }
                     }catch(error2)
                     {
                       snackBar(context, "Error");
                     };
                     isLoading=false;
                   }


                 },
               ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RegisterScreen.id);
                    }, child: Text(
                      "Sign Up",
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



  Future<void> userLogin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail!,
        password: password!);
  }
}
