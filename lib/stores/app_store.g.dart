// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$remaindersAtom =
      Atom(name: '_AppStore.remainders', context: context);

  @override
  Map<String, List<Remainder>> get remainders {
    _$remaindersAtom.reportRead();
    return super.remainders;
  }

  @override
  set remainders(Map<String, List<Remainder>> value) {
    _$remaindersAtom.reportWrite(value, super.remainders, () {
      super.remainders = value;
    });
  }

  late final _$remaindersLoadingAtom =
      Atom(name: '_AppStore.remaindersLoading', context: context);

  @override
  bool get remaindersLoading {
    _$remaindersLoadingAtom.reportRead();
    return super.remaindersLoading;
  }

  @override
  set remaindersLoading(bool value) {
    _$remaindersLoadingAtom.reportWrite(value, super.remaindersLoading, () {
      super.remaindersLoading = value;
    });
  }

  late final _$tasksLoadingAtom =
      Atom(name: '_AppStore.tasksLoading', context: context);

  @override
  bool get tasksLoading {
    _$tasksLoadingAtom.reportRead();
    return super.tasksLoading;
  }

  @override
  set tasksLoading(bool value) {
    _$tasksLoadingAtom.reportWrite(value, super.tasksLoading, () {
      super.tasksLoading = value;
    });
  }

  late final _$addRemainderDaysAtom =
      Atom(name: '_AppStore.addRemainderDays', context: context);

  @override
  List<String> get addRemainderDays {
    _$addRemainderDaysAtom.reportRead();
    return super.addRemainderDays;
  }

  @override
  set addRemainderDays(List<String> value) {
    _$addRemainderDaysAtom.reportWrite(value, super.addRemainderDays, () {
      super.addRemainderDays = value;
    });
  }

  late final _$addingRemainderAtom =
      Atom(name: '_AppStore.addingRemainder', context: context);

  @override
  bool get addingRemainder {
    _$addingRemainderAtom.reportRead();
    return super.addingRemainder;
  }

  @override
  set addingRemainder(bool value) {
    _$addingRemainderAtom.reportWrite(value, super.addingRemainder, () {
      super.addingRemainder = value;
    });
  }

  late final _$userAtom = Atom(name: '_AppStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$addRemainderDateAndTimeAtom =
      Atom(name: '_AppStore.addRemainderDateAndTime', context: context);

  @override
  DateTime get addRemainderDateAndTime {
    _$addRemainderDateAndTimeAtom.reportRead();
    return super.addRemainderDateAndTime;
  }

  @override
  set addRemainderDateAndTime(DateTime value) {
    _$addRemainderDateAndTimeAtom
        .reportWrite(value, super.addRemainderDateAndTime, () {
      super.addRemainderDateAndTime = value;
    });
  }

  late final _$addCategoryTextAtom =
      Atom(name: '_AppStore.addCategoryText', context: context);

  @override
  String get addCategoryText {
    _$addCategoryTextAtom.reportRead();
    return super.addCategoryText;
  }

  @override
  set addCategoryText(String value) {
    _$addCategoryTextAtom.reportWrite(value, super.addCategoryText, () {
      super.addCategoryText = value;
    });
  }

  late final _$addTaskTextAtom =
      Atom(name: '_AppStore.addTaskText', context: context);

  @override
  String? get addTaskText {
    _$addTaskTextAtom.reportRead();
    return super.addTaskText;
  }

  @override
  set addTaskText(String? value) {
    _$addTaskTextAtom.reportWrite(value, super.addTaskText, () {
      super.addTaskText = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_AppStore.selectedCategory', context: context);

  @override
  String? get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String? value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$addCategoryLoadingAtom =
      Atom(name: '_AppStore.addCategoryLoading', context: context);

  @override
  bool get addCategoryLoading {
    _$addCategoryLoadingAtom.reportRead();
    return super.addCategoryLoading;
  }

  @override
  set addCategoryLoading(bool value) {
    _$addCategoryLoadingAtom.reportWrite(value, super.addCategoryLoading, () {
      super.addCategoryLoading = value;
    });
  }

  late final _$categoriesAtom =
      Atom(name: '_AppStore.categories', context: context);

  @override
  List<TaskCategory> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<TaskCategory> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$themeAtom = Atom(name: '_AppStore.theme', context: context);

  @override
  ThemeEnum get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(ThemeEnum value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$toggleRemianderAsyncAction =
      AsyncAction('_AppStore.toggleRemiander', context: context);

  @override
  Future<bool> toggleRemiander(
      String categoryId, String id, int index, bool state) {
    return _$toggleRemianderAsyncAction
        .run(() => super.toggleRemiander(categoryId, id, index, state));
  }

  late final _$setAddRemainderDateAsyncAction =
      AsyncAction('_AppStore.setAddRemainderDate', context: context);

  @override
  Future<dynamic> setAddRemainderDate(BuildContext context) {
    return _$setAddRemainderDateAsyncAction
        .run(() => super.setAddRemainderDate(context));
  }

  late final _$setAddRemainderTimeAsyncAction =
      AsyncAction('_AppStore.setAddRemainderTime', context: context);

  @override
  Future<dynamic> setAddRemainderTime(BuildContext context) {
    return _$setAddRemainderTimeAsyncAction
        .run(() => super.setAddRemainderTime(context));
  }

  late final _$getRemaindersForCategoryAsyncAction =
      AsyncAction('_AppStore.getRemaindersForCategory', context: context);

  @override
  Future<dynamic> getRemaindersForCategory(String id) {
    return _$getRemaindersForCategoryAsyncAction
        .run(() => super.getRemaindersForCategory(id));
  }

  late final _$runAfterLoginAsyncAction =
      AsyncAction('_AppStore.runAfterLogin', context: context);

  @override
  Future<dynamic> runAfterLogin() {
    return _$runAfterLoginAsyncAction.run(() => super.runAfterLogin());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_AppStore.addTask', context: context);

  @override
  Future<bool> addTask() {
    return _$addTaskAsyncAction.run(() => super.addTask());
  }

  late final _$addCategoryToDBAsyncAction =
      AsyncAction('_AppStore.addCategoryToDB', context: context);

  @override
  Future<dynamic> addCategoryToDB() {
    return _$addCategoryToDBAsyncAction.run(() => super.addCategoryToDB());
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void selectDayToAddRemainder(String d) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.selectDayToAddRemainder');
    try {
      return super.selectDayToAddRemainder(d);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddCategoryText(String d) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setAddCategoryText');
    try {
      return super.setAddCategoryText(d);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(String? d) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setSelectedCategory');
    try {
      return super.setSelectedCategory(d);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddTaskText(String? d) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setAddTaskText');
    try {
      return super.setAddTaskText(d);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTheme(ThemeEnum themeEnum) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setTheme');
    try {
      return super.setTheme(themeEnum);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
remainders: ${remainders},
remaindersLoading: ${remaindersLoading},
tasksLoading: ${tasksLoading},
addRemainderDays: ${addRemainderDays},
addingRemainder: ${addingRemainder},
user: ${user},
addRemainderDateAndTime: ${addRemainderDateAndTime},
addCategoryText: ${addCategoryText},
addTaskText: ${addTaskText},
selectedCategory: ${selectedCategory},
addCategoryLoading: ${addCategoryLoading},
categories: ${categories},
isLoggedIn: ${isLoggedIn},
theme: ${theme}
    ''';
  }
}
