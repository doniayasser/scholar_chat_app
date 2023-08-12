import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/shared/components/constants.dart';

import '../shared/components/components.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key, this.chatId}) : super(key: key);
  static String id="ChatPage";
  var chatId;
  TextEditingController controller=TextEditingController();
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
  final listController=ScrollController();
  @override
  Widget build(BuildContext context) {
    chatId=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kMessageTime,descending: true).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              List<MessageModel>chatMessages=[];
              for(int i=0;i<snapshot.data!.docs.length;i++)
                {
                  chatMessages.add(MessageModel.fromJson(snapshot.data!.docs[i]));
                }

              return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: kPrimaryColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(kLogo,height: 55.0,),
                        Text("Chat"),

                      ],
                    ),
                  ),
                  body: Column(
                    children:[
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: listController,
                          itemCount: chatMessages.length,
                          itemBuilder: (context, index) {
                          return chatMessages[index].messageId==chatId?
                          ChatBubble(messages: chatMessages[index],):
                          ChatBubbleFriend(messages: chatMessages[index],)
                          ;
                        },
                        ),
                      ),
                      // Spacer(flex: 1,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          controller: controller,
                          onSubmitted: (data) {
                            messages.add({
                                  kMessage:data,
                                  kMessageId:chatId,
                                  kMessageTime:DateTime.now(),
                                  }
                            );
                            controller.clear();
                            listController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);

                          },
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                )
                            ),
                            hintText: "Send message",
                            suffixIcon: const Icon(Icons.send,color: kPrimaryColor),),
                        ),
                      ),],
                  )

              );
            }
          else
            {
              return const Center(child: Text(
                  "Loading.........",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white12,
                ),
              ));
            }
        },
    );
  }
}
