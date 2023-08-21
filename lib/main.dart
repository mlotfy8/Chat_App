import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/Cubit/chat_cubit.dart';
import 'package:fluttertest/Cubit/login_cubit.dart';
import 'package:fluttertest/Cubit/singin_cubit.dart';
import 'package:fluttertest/home.dart';
import 'package:fluttertest/homechat.dart';

import 'firebase_options.dart';

var user = FirebaseAuth.instance.currentUser!.email;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SinginCubit()),
        BlocProvider(create: (context) => ChatCubit())

      ],
      child: MaterialApp(
        home:FirebaseAuth.instance.currentUser!.email==user?homechat(): home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
