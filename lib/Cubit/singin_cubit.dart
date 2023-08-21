import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'singin_state.dart';

class SinginCubit extends Cubit<SinginState> {
  UserCredential? credential;

  SinginCubit() : super(SinginInitial());

  Singinuser({required String email, required String pass}) async {
    emit(SinginLoading());

    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(SinginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SinginFaluier());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
