import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);
  factory Message.fromJason(jasonData) {
    return Message(jasonData[kMessage], jasonData['id']);
  }
}
