import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/widgets/chatboble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'chatpage';
  @override
  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(kMessagesCollictons);
    TextEditingController textEditingController = TextEditingController();
    final scrollController = ScrollController();
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJason(snapshot.data!.docs[i]));
          }

          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      logo,
                      height: 60,
                    ),
                    const Text(
                      'chat',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                  ],
                ),
                centerTitle: true,
                automaticallyImplyLeading: false),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBoble(
                              message: messagesList[index],
                            )
                          : ChatBobleforFrind(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (value) {
                      messages.add({
                        kMessage: value,
                        kCreatedAt: DateTime.now(),
                        'id': email
                      });
                      textEditingController.clear();
                      scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          )),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor)),
                    ),
                  ),
                )
              ],
            ),
          ));
        } else {
          return const Text('lodding');
        }
      },
    );
  }
}
