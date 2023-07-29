import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  bool isLoggingIn = false;

  @observable
  String userEmail = '';
  @observable
  String password = '';
  @observable
  String? error;

  @action
  void setUserMail(String email) {
    userEmail = email.trim();
  }

  @action
  void setPassword(String pass) {
    password = pass.trim();
  }

  @action
  Future logIn() async {
    if (userEmail.isEmpty) {
      error = "Enter Email";
      return;
    }
    if (password.isEmpty) {
      error = "Enter Password";
      return;
    }
    isLoggingIn = true;
    error = null;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          error = "Not Registered";
          break;
        default:
          error = e.code;
      }
    } finally {
      isLoggingIn = false;
    }
  }
}
