import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textformfeild extends StatelessWidget {
  var controller, lable, valid;
  IconButton? suf;
  bool? obs;

  textformfeild(
      {this.controller, this.lable, this.valid, this.obs = false, this.suf});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: valid,
        obscureText: obs!,
        decoration: InputDecoration(
            suffixIcon: suf,
            label: Text('$lable'),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
