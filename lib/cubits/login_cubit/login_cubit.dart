import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

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
}
