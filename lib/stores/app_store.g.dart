// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$tasksAtom = Atom(name: '_AppStore.tasks', context: context);

  @override
  Map<String, List<Tasks>> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(Map<String, List<Tasks>> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
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

  late final _$addingTaskAtom =
      Atom(name: '_AppStore.addingTask', context: context);

  @override
  bool get addingTask {
    _$addingTaskAtom.reportRead();
    return super.addingTask;
  }

  @override
  set addingTask(bool value) {
    _$addingTaskAtom.reportWrite(value, super.addingTask, () {
      super.addingTask = value;
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

  late final _$getTasksForCategoryAsyncAction =
      AsyncAction('_AppStore.getTasksForCategory', context: context);

  @override
  Future<dynamic> getTasksForCategory(String id) {
    return _$getTasksForCategoryAsyncAction
        .run(() => super.getTasksForCategory(id));
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
  Future<dynamic> addTask() {
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
tasks: ${tasks},
tasksLoading: ${tasksLoading},
addingTask: ${addingTask},
user: ${user},
addCategoryText: ${addCategoryText},
selectedCategory: ${selectedCategory},
addCategoryLoading: ${addCategoryLoading},
categories: ${categories},
isLoggedIn: ${isLoggedIn},
theme: ${theme}
    ''';
  }
}
