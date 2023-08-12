import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';

import 'constants.dart';

class TextFieldComponent extends StatelessWidget {
  TextFieldComponent(this.fieldName,{this.prefix,this.suffix,this.change,this.obsecurePass=false});
  final String? fieldName;
  final Icon? prefix;
  final Icon? suffix;
  final Function(String)? change;
  bool? obsecurePass;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecurePass!,
      validator: (data){
        if(data!.isEmpty)
          return "This field can't be empty";
      },
      onChanged: change,
      decoration:  InputDecoration(
        label: Text(
          fieldName!,
          style: TextStyle(color: Colors.white,),
        ),
        border: const OutlineInputBorder(),
        prefixIcon: prefix,
        suffixIcon: suffix,
        enabledBorder:  OutlineInputBorder(

            // borderSide: BorderSide(
            //   color: Colors.white,
            // ),
        ),

      ),
      keyboardType: TextInputType.emailAddress,
    );}
}

class ButtonComponent extends StatefulWidget {
   ButtonComponent({this.buttonLabel,this.tapped});

  final String? buttonLabel;
  final VoidCallback? tapped;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.tapped,
      child: Container(
        width: double.infinity,
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

        ),
        child: Center(child: Text(
          widget.buttonLabel!,
          style: TextStyle(
            fontSize: 24,

          ),

        )),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({this.messages, Key? key}) : super(key: key) ;
  final MessageModel? messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding:  const EdgeInsets.only(left: 15.0,bottom: 18.0,top: 18.0,right: 15.0),
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
                bottomRight: Radius.circular(22.0),
              )
          ),

          child: Column(
            children: [
              Text(
                messages!.mess,
                style: TextStyle(

                  color: Colors.white,
                ),
              ),
               Text(
                 "${DateTime.now().hour}:${DateTime.now().minute}",
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 8.0,
                 ),
               ),
            ],
          ),
        ),
      ),

    );}
}

class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend({this.messages, Key? key}) : super(key: key) ;
  final MessageModel? messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding:  const EdgeInsets.only(left: 15.0,bottom: 18.0,top: 18.0,right: 15.0),
          decoration: const BoxDecoration(
              color: Color(0xff006D99),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
                bottomLeft: Radius.circular(22.0),
              )
          ),

          child: Column(
            children: [
              Text(
                messages!.mess,
                style: const TextStyle(

                  color: Colors.white,
                ),
              ),
              Text(
                "${DateTime.now().hour}:${DateTime.now().minute}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8.0,
                ),
              ),
            ],
          ),
        ),
      ),

    );}
}

void snackBar(BuildContext context,String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white70,
      content: Text(message!,
        style: TextStyle(
          color: Colors.black,
        ),
      ),),);
  print("error");
}
