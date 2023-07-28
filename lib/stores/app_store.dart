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
  static final remaindersRef =
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
  Map<String, List<Remainder>> remainders = {};
  @observable
  bool remaindersLoading = false;
  @observable
  bool tasksLoading = false;
  @observable
  List<String> addRemainderDays = [];
  @observable
  bool addingRemainder = false;
  @action
  Future<bool> toggleRemiander(
      String categoryId, String id, int index, bool state) async {
    try {
      await updateDoc(remaindersRef.doc(id), {"enabled": state});
      remainders[categoryId]![index].enabled = state;
      return true;
    } catch (e) {
      return false;
    } finally {
      remainders = ObservableMap.of(remainders);
    }
  }

  @action
  Future setAddRemainderDate(BuildContext context) async {
    final date = await showDatePicker(
      initialDate: addRemainderDateAndTime,
      context: context,
      firstDate: addRemainderDateAndTime,
      lastDate: DateTime(
        addRemainderDateAndTime.year * 2,
      ),
    );
    if (date != null) {
      addRemainderDateAndTime = DateTime(
        date.year,
        date.month,
        date.day,
        addRemainderDateAndTime.hour,
        addRemainderDateAndTime.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    }
  }

  @action
  Future setAddRemainderTime(BuildContext context) async {
    final date = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(
        addRemainderDateAndTime,
      ),
      context: context,
    );
    if (date != null) {
      addRemainderDateAndTime = DateTime(
        addRemainderDateAndTime.year,
        addRemainderDateAndTime.month,
        addRemainderDateAndTime.day,
        date.hour,
        date.minute,
        addRemainderDateAndTime.second,
      );
    }
  }

  @action
  void selectDayToAddRemainder(String d) {
    final presentIndex = addRemainderDays.indexOf(d);
    if (presentIndex == -1) {
      addRemainderDays.add(d);
    } else {
      addRemainderDays.removeAt(presentIndex);
    }
    addRemainderDays = ObservableList.of(addRemainderDays);
  }

  @action
  Future getRemaindersForCategory(String id) async {
    bool alreadyDownloaded = remainders.containsKey(id);
    if (alreadyDownloaded) return;
    remaindersLoading = true;
    try {
      final tasks = await getTasks(remaindersRef, id);
      this.remainders.putIfAbsent(id, () => tasks);
      this.remainders = ObservableMap.of(this.remainders);
    } catch (e) {
      print(e);
    } finally {
      remaindersLoading = false;
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
  DateTime addRemainderDateAndTime = DateTime.now();
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
      addingRemainder = true;
      final taskDoc = await addRemainderToDB(remaindersRef, {
        "task": addTaskText,
        "createdAt": FieldValue.serverTimestamp(),
        "time": addRemainderDateAndTime,
        "days": addRemainderDays,
        "categoryId": selectedCategory,
        "enabled": true,
      });
      final taskToAdd = Remainder.fromJSON({
        ...{
          "task": addTaskText,
          "createdAt": DateTime.now(),
          "time": addRemainderDateAndTime,
          "days": addRemainderDays,
          "categoryId": selectedCategory,
          "id": taskDoc.id,
          "enabled": true,
        }
      });
      if (remainders.containsKey(selectedCategory)) {
        remainders[selectedCategory]!.add(taskToAdd);
      } else {
        remainders[selectedCategory!] = [taskToAdd];
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      addingRemainder = false;
      addTaskText = null;
      selectedCategory = null;
      addRemainderDays.clear();
      addRemainderDateAndTime = DateTime.now();
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
