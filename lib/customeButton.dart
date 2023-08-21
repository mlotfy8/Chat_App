import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  var text,tap;
  CustomeButton({this.text,this.tap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: tap,
      child: Container(
        height: 50,
        width: 300,
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white,),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blue),
      ),
    );
}}
