import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/widgets/chatboble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'chatpage';

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final scrollController = ScrollController();
    String email = ModalRoute.of(context)!.settings.arguments as String;

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
                    fontSize: 20, color: Colors.white, fontFamily: 'pacifico'),
              ),
            ],
          ),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                List<Message> messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBoble(
                            message: messagesList[index],
                          )
                        : ChatBobleforFrind(
                            message: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: textEditingController,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: value, email: email);
                BlocProvider.of<ChatCubit>(context).getMessages();
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
  }
}
