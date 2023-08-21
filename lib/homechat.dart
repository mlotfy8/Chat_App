import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/Cubit/chat_cubit.dart';
import 'package:fluttertest/conestes.dart';

import 'ChatBubble.dart';

class homechat extends StatefulWidget {
  const homechat({super.key});

  @override
  State<homechat> createState() => _homechatState();
}

class _homechatState extends State<homechat> {
  final listcontrole = ScrollController();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  List ListMessage = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ChatApp',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: KprimaryColor,
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: collectionReference
                  .orderBy('now', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BlocConsumer<ChatCubit, ChatState>(
                    listener: (context, state) {
                      if (state is ChatSuccess) {
                        ListMessage.add(state.ListMessage);
                      }
                    },
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: listcontrole,
                          itemBuilder: (context, index) => snapshot
                                      .data!.docs[index]
                                      .get('id') ==
                                  FirebaseAuth.instance.currentUser!.email
                              ? ChatBuble(
                                  message:
                                      '${snapshot.data!.docs[index].get('message')}',
                                  time:
                                      "${snapshot.data!.docs[index].get('time')}",
                                )
                              : ChatBubleForFriend(
                                  message:
                                      snapshot.data!.docs[index].get('message'),
                                  time: snapshot.data!.docs[index].get('time'),
                                ),
                          itemCount: snapshot.data!.docs.length,
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formstate,
                child: TextFormField(
                  controller: message,
                  validator: (val) {
                    if (val!.isEmpty == true) {
                      return 'enter message';
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (formstate.currentState!.validate()) {
                            BlocProvider.of<ChatCubit>(context).addMessage(
                                message: message.text, email: email!);
                            message.clear();
                            listcontrole.animateTo(0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                      hintText: 'Send Message',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            )
          ],
        ));
  }

  var email = FirebaseAuth.instance.currentUser!.email;
}
/*

 */
