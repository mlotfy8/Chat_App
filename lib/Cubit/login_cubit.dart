import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  UserCredential? credential;

  LoginCubit() : super(LoginInitial());

  emit(LoginLoading);

  Lodinuser({required String email, required String pass}) async {
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFaluier());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
