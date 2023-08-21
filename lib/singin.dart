import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/Cubit/singin_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'conestes.dart';
import 'customeButton.dart';
import 'custometextfeild.dart';
import 'homechat.dart';

class singin extends StatefulWidget {
  const singin({super.key});

  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('name');
  bool isloading = false;
  bool visi = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return BlocConsumer<SinginCubit, SinginState>(
        listener: (context, state) {
          if (state is SinginLoading) {
            isloading = true;
          } else if (state is SinginSuccess) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => homechat()));
            isloading = false;
          } else {
            AwesomeDialog(
                context: context,
                title: 'Error',
                body: Row(
                  children: [
                    Container(
                        height: 30,
                        child: Center(
                          child: Text(
                            '        Oops Something went wrong',
                            style: TextStyle(fontSize: 16,
                                color: Colors.red, fontFamily: 'NotoSerif'),
                          ),
                        )),
                  ],
                ))
              ..show();
            isloading = false;
          }
        },
        builder: (context, state) =>
            ModalProgressHUD(
              inAsyncCall: isloading,
              child: Scaffold(
                backgroundColor: KprimaryColor,
                body: SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: h - 700,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Image.asset('$Klogo')],
                        ),
                        Text(
                          'Chat App',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: h - 780,
                        ),
                        Text(
                          'SingIn',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: h - 780,
                        ),
                        Form(
                          key: formstate,
                          child: Column(
                            children: [
                              textformfeild(
                                  lable: 'email',
                                  controller: email,
                                  valid: (val) {
                                    if (val == '') return 'Required feild';
                                    if (val!.contains('@gmail.com') == false)
                                      return 'Invalid email';
                                  }),
                              textformfeild(
                                suf: IconButton(
                                  onPressed: () {},
                                  icon: visi == true
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                                lable: 'password',
                                valid: (val) {
                                  if (val == '') return 'Required feild';
                                  if (pass.text.length < 8)
                                    return 'password can`t be less than 8 letters';
                                },
                                controller: pass,
                                obs: visi,
                              ),
                              SizedBox(
                                height: h - 790,
                              ),
                            ],
                          ),
                        ),
                        CustomeButton(
                            text: 'SingIn',
                            tap: () async {
                              if (formstate.currentState!.validate()) {
                                BlocProvider.of<SinginCubit>(context)
                                    .Singinuser(
                                    email: email.text, pass: pass.text);
                              }
                            }),
                        SizedBox(
                          height: h - 780,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have account',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: w - 350,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
