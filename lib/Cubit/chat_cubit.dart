import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('messages');

  ChatCubit() : super(ChatInitial());
  Future<void> addMessage(
      {required String message, required String email}) async {
    await collectionReference.add({
      'message': '${message}',
      'time': '${Jiffy.now().jm}',
      'now': DateTime.now(),
      'id': '$email'
    });
  }

  voidgetMessages() {
    List<Message> ListMessage = [];
    collectionReference
        .orderBy('now', descending: true)
        .snapshots()
        .listen((event) {
  for(var doc in event.docs)
    {
      ListMessage.add(Message.fromJson(doc));
    }
      print('========================Success');
      print('========================${ListMessage}');
      emit(ChatSuccess(ListMessage: ListMessage));
    });
  }
}
