import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:remainder/db/getters.dart';
import 'package:remainder/models/tasks.dart';
import 'package:remainder/stores/login_store.dart';
import 'package:remainder/stores/nav_store.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/utils.dart';
part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

enum ThemeEnum { light, dark, system }

abstract class _AppStore with Store {
  static final categoriesRef =
      FirebaseFirestore.instance.collection(CollectionKeys.categories);
  static final tasksRef =
      FirebaseFirestore.instance.collection(CollectionKeys.todos);
  _AppStore() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        isLoggedIn = false;
        navStore.setScreen(Screen.login);
        return;
      }
      isLoggedIn = true;
      this.user = user;
      runAfterLogin();
    });
  }
  @observable
  Map<String, List<Tasks>> tasks = {};
  @observable
  bool tasksLoading = false;
  @observable
  bool addingTask = false;
  @action
  Future getTasksForCategory(String id) async {
    bool alreadyDownloaded = tasks.containsKey(id);
    if (alreadyDownloaded) return;
    tasksLoading = true;
    try {
      final tasks = await getTasks(tasksRef, id);
      this.tasks.putIfAbsent(id, () => tasks);
      this.tasks = ObservableMap.of(this.tasks);
    } catch (e) {
      print(e);
    } finally {
      tasksLoading = false;
    }
  }

  @action
  Future runAfterLogin() async {
    try {
      final categories = await getCategories(categoriesRef, userUID);
      this.categories = ObservableList.of(categories);
    } catch (e) {
      print(e);
    } finally {}
  }

  @observable
  User? user;

  String get userUID {
    if (user != null) {
      return user!.uid;
    }
    return "";
  }

  @observable
  String addCategoryText = '';
  @observable
  String? selectedCategory;
  @observable
  bool addCategoryLoading = false;
  @observable
  List<TaskCategory> categories = [];
  @observable
  bool isLoggedIn = false;
  @observable
  ThemeEnum theme = ThemeEnum.light;

  @action
  void setAddCategoryText(String d) {
    addCategoryText = d.trim();
  }

  @action
  void setSelectedCategory(String? d) {
    selectedCategory = d;
  }

  @action
  Future addTask() async {}
  @action
  Future addCategoryToDB() async {
    if (addCategoryText.isEmpty) {
      return;
    }
    addCategoryLoading = true;
    try {
      Map<String, dynamic> data = {'userId': userUID, 'name': addCategoryText};
      DocumentReference docRef = await categoriesRef.add(data);
      categories.add(TaskCategory(id: docRef.id, name: addCategoryText));
      categories = ObservableList.of(categories);
    } catch (e) {
      print(e);
    } finally {
      addCategoryText = '';
      addCategoryLoading = false;
    }
  }

  @action
  void setTheme(ThemeEnum themeEnum) {
    theme = theme != ThemeEnum.dark ? ThemeEnum.dark : ThemeEnum.light;
  }

  NavStore navStore = NavStore();
  LoginStore loginStore = LoginStore();
}
