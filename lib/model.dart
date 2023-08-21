
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[FirebaseAuth.instance.currentUser!.email], jsonData['id']);
  }
}