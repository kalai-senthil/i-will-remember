import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:remainder/db/getters.dart';
import 'package:remainder/db/setters.dart';
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
      FirebaseFirestore.instance.collection(CollectionKeys.tasks);
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
  List<String> addTasksDays = [];
  @observable
  bool addingTask = false;
  @action
  Future setAddTaskDate(BuildContext context) async {
    final date = await showDatePicker(
      initialDate: addTaskDateAndTime,
      context: context,
      firstDate: addTaskDateAndTime,
      lastDate: DateTime(
        addTaskDateAndTime.year * 2,
      ),
    );
    if (date != null) {
      addTaskDateAndTime = DateTime(
        date.year,
        date.month,
        date.day,
        addTaskDateAndTime.hour,
        addTaskDateAndTime.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    }
  }

  @action
  Future setAddTaskTime(BuildContext context) async {
    final date = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(
        addTaskDateAndTime,
      ),
      context: context,
    );
    if (date != null) {
      addTaskDateAndTime = DateTime(
        addTaskDateAndTime.year,
        addTaskDateAndTime.month,
        addTaskDateAndTime.day,
        date.hour,
        date.minute,
        addTaskDateAndTime.second,
      );
    }
  }

  @action
  void selectDayToAddTask(String d) {
    final presentIndex = addTasksDays.indexOf(d);
    if (presentIndex == -1) {
      addTasksDays.add(d);
    } else {
      addTasksDays.removeAt(presentIndex);
    }
    addTasksDays = ObservableList.of(addTasksDays);
  }

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
  DateTime addTaskDateAndTime = DateTime.now();
  @observable
  String addCategoryText = '';
  @observable
  String? addTaskText;
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
  void setAddTaskText(String? d) {
    if (d == null) return;
    addTaskText = d.trim();
  }

  @action
  Future<bool> addTask() async {
    try {
      if (selectedCategory == null) {
        return false;
      }
      addingTask = true;
      final taskDoc = await addTaskToDB(tasksRef, {
        "task": addTaskText,
        "createdAt": FieldValue.serverTimestamp(),
        "time": addTaskDateAndTime,
        "days": addTasksDays,
        "categoryId": selectedCategory,
        "enabled": true,
      });
      final taskToAdd = Tasks.fromJSON({
        ...{
          "task": addTaskText,
          "createdAt": DateTime.now(),
          "time": addTaskDateAndTime,
          "days": addTasksDays,
          "categoryId": selectedCategory,
          "id": taskDoc.id,
          "enabled": true,
        }
      });
      if (tasks.containsKey(selectedCategory)) {
        tasks[selectedCategory]!.add(taskToAdd);
      } else {
        tasks[selectedCategory!] = [taskToAdd];
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      addingTask = false;
      addTaskText = null;
      selectedCategory = null;
      addTasksDays.clear();
      addTaskDateAndTime = DateTime.now();
    }
  }

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
