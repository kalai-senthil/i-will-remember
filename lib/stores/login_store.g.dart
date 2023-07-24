// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$isLoggingInAtom =
      Atom(name: '_LoginStore.isLoggingIn', context: context);

  @override
  bool get isLoggingIn {
    _$isLoggingInAtom.reportRead();
    return super.isLoggingIn;
  }

  @override
  set isLoggingIn(bool value) {
    _$isLoggingInAtom.reportWrite(value, super.isLoggingIn, () {
      super.isLoggingIn = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_LoginStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$errorAtom = Atom(name: '_LoginStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$logInAsyncAction =
      AsyncAction('_LoginStore.logIn', context: context);

  @override
  Future<dynamic> logIn() {
    return _$logInAsyncAction.run(() => super.logIn());
  }

  late final _$_LoginStoreActionController =
      ActionController(name: '_LoginStore', context: context);

  @override
  void setUserMail(String email) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setUserMail');
    try {
      return super.setUserMail(email);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String pass) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setPassword');
    try {
      return super.setPassword(pass);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggingIn: ${isLoggingIn},
userEmail: ${userEmail},
password: ${password},
error: ${error}
    ''';
  }
}
