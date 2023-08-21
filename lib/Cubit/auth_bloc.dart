import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserCredential? credential;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      String? error;
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.pass);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
           emit(LoginFaluier(errorMessage: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFaluier(errorMessage: 'Wrong password provided for that user.'));
          }
        }
      }
    });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    print('===================$transition');
    super.onTransition(transition);
  }
}
