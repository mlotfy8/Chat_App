import 'package:flutter/material.dart';
import 'package:fluttertest/conestes.dart';
import 'package:fluttertest/model.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({Key? key, required this.message, required this.time})
      : super(key: key);

  var message, time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 15, bottom: 10, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Colors.teal[900],
        ),
        child: Column(
          children: [
            Text(
              message,
              style: TextStyle(
                color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500
              ),
            ),SizedBox(height: 5,),
            Text(
              time,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),fontSize: 15
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({
    Key? key,
    required this.message,required this.time
  }) : super(key: key);

  var message, time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 15, bottom: 10, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Column(
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500
              ),
            ),SizedBox(height: 5,),
            Text(
              time,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),fontSize: 15
              ),
            ),
          ],
        ),
      ),
    );
  }
}
