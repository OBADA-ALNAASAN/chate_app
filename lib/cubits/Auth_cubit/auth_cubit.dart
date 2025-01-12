
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
    Future<void> loginUser(
      {required String email, required String password}) async {
    emit(Loginloding());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    }on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                               emit(LoginFailure(errtext:  'user-not-found'));
                              
                            } else if (e.code == 'wrong-password') {
                              
                             emit(LoginFailure(errtext: 'wrong-password'));
                            }
                          }  catch (_) {
      emit(LoginFailure(errtext:'something was wrong'));
    }
  }
    Future<void> registerUser(String? email, String? password) async {
    try {
      emit(Registerloding());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errtext:'The password provided is too weak.' ));
      
      } else if (e.code == 'email-already-in-use') {
         emit(RegisterFailure(errtext:'The account already exists for that email.'));
        
      }
    } catch (e) {
       emit(RegisterFailure(errtext:e.toString()));
    }
  }
}
