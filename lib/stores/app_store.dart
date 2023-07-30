import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:remainder/db/getters.dart';
import 'package:remainder/db/setters.dart';
import 'package:remainder/main.dart';
import 'package:remainder/models/remainder.dart';
import 'package:remainder/models/todo.dart';
import 'package:remainder/stores/login_store.dart';
import 'package:remainder/stores/nav_store.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/ui/toast_animation.dart';
import 'package:remainder/utils.dart';
part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

enum ThemeEnum { light, dark, system }

enum ToastEnum { error, success }

abstract class _AppStore with Store {
  static final categoriesRef =
      FirebaseFirestore.instance.collection(CollectionKeys.categories);
  static final remaindersRef =
      FirebaseFirestore.instance.collection(CollectionKeys.remainders);
  static final todosRef =
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
  Map<String, List<Remainder>> remainders = {};
  @observable
  Map<String, List<Todo>> todos = {};
  @observable
  bool remaindersLoading = false;
  @observable
  bool todosLoading = false;
  @observable
  bool addingTodoLoading = false;
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
      showToast(ToastEnum.success, "Remainder Updated");
      return true;
    } catch (e) {
      showToast(ToastEnum.error, "Update Error");
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
  Future getRemaindersForCategory(String id, {bool refresh = false}) async {
    if (refresh) {
      remainders.clear();
    } else {
      bool alreadyDownloaded = remainders.containsKey(id);
      if (alreadyDownloaded) return;
    }
    remaindersLoading = true;
    try {
      final tasks = await getRemainders(remaindersRef, id);
      remainders.putIfAbsent(id, () => tasks);
      remainders = ObservableMap.of(remainders);
    } catch (e) {
      showToast(ToastEnum.error, "Error getting remainders");
    } finally {
      remaindersLoading = false;
    }
  }

  @action
  Future getTodosForCategory(String id, {bool refresh = false}) async {
    if (refresh) {
      todos.clear();
    } else {
      bool alreadyDownloaded = todos.containsKey(id);
      if (alreadyDownloaded) return;
    }
    todosLoading = true;
    try {
      final todos = await getTodos(todosRef, id);
      this.todos.putIfAbsent(id, () => todos);
      this.todos = ObservableMap.of(this.todos);
    } catch (e) {
      showToast(ToastEnum.error, "Error getting todos");
    } finally {
      todosLoading = false;
    }
  }

  @action
  Future runAfterLogin() async {
    try {
      final categories = await getCategories(categoriesRef, userUID);
      this.categories = ObservableList.of(categories);
    } catch (e) {
      showToast(ToastEnum.error, "Unable to get categories");
    } finally {}
  }

  FToast? toast;
  AnimationController? controller;

  void setToastInstance(FToast toast) {
    this.toast = toast;
  }

  void showToast(ToastEnum type, String info) {
    toast ??= FToast().init(navigatorKey.currentContext!);
    switch (type) {
      case ToastEnum.error:
        toast!.showToast(
          toastDuration: const Duration(seconds: 3),
          child: ToastAnimation(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                boxShadow: Utils.cardBtnShadow,
                borderRadius: Utils.borderRadiusRoundedCard,
                color: Utils.lightSecondaryColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                  ),
                  Text(
                    info,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case ToastEnum.success:
        toast!.showToast(
          toastDuration: const Duration(seconds: 3),
          child: ToastAnimation(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                boxShadow: Utils.cardBtnShadow,
                borderRadius: Utils.borderRadiusRoundedCard,
                color: Utils.lightSecondaryColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_rounded,
                    color: Colors.greenAccent,
                  ),
                  Text(
                    info,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      default:
    }
  }

  @action
  void reloadCategory(String id) {
    try {
      getTodosForCategory(id, refresh: true);
      getRemaindersForCategory(id, refresh: true);
      showToast(ToastEnum.success, "Content Updated");
    } catch (e) {
      showToast(ToastEnum.error, "Error Reloading");
    }
  }

  @action
  Future updateTodo(Todo todo, {required bool state}) async {
    try {
      await updateDoc(todosRef.doc(todo.id), {"completed": state});
      todos[todo.categoryId]!
          .firstWhere((element) => element.id == todo.id)
          .completed = state;
      showToast(ToastEnum.success, "Todo Updated");
      todos = ObservableMap.of(todos);
    } catch (e) {
      showToast(ToastEnum.error, "Unable to update todo");
    } finally {}
  }

  @observable
  User? user;
  @computed
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
  String addTodoText = '';
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
  void setAddTodoText(String d) {
    addTodoText = d.trim();
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
        "userId": userUID,
      });
      final taskToAdd = Remainder.fromJSON(
        {
          "task": addTaskText,
          "createdAt": DateTime.now(),
          "time": addRemainderDateAndTime,
          "days": addRemainderDays,
          "categoryId": selectedCategory,
          "id": taskDoc.id,
          "enabled": true,
        },
      );
      if (remainders.containsKey(selectedCategory)) {
        remainders[selectedCategory]!.add(taskToAdd);
      } else {
        remainders[selectedCategory!] = [taskToAdd];
      }
      showToast(ToastEnum.success, "Added Successfully");
      return true;
    } catch (e) {
      showToast(ToastEnum.success, "Unable to add Todo");
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
      showToast(ToastEnum.error, "Added Successfully");
    } catch (e) {
      showToast(ToastEnum.error, "Updation Error");
    } finally {
      addCategoryText = '';
      addCategoryLoading = false;
    }
  }

  @action
  Future addTaskToDB(String catId) async {
    if (addTodoText.isEmpty) {
      return;
    }
    addingTodoLoading = true;
    try {
      Map<String, dynamic> data = {
        "todo": addTodoText,
        "completed": false,
        "createdAt": FieldValue.serverTimestamp(),
        "categoryId": catId,
        "userId": userUID,
      };
      DocumentReference docRef = await todosRef.add(data);
      data['createdAt'] = DateTime.now();
      Todo todo = Todo.fromJSON({
        ...data,
        "id": docRef.id,
      });
      if (todos.containsKey(catId)) {
        todos[catId]!.add(todo);
      } else {
        todos[catId] = [todo];
      }
      showToast(ToastEnum.success, "Remiander added");
      todos = ObservableMap.of(todos);
    } catch (e) {
      showToast(ToastEnum.error, "Adding Remainder failed");
    } finally {
      addTodoText = '';
      addingTodoLoading = false;
    }
  }

  @action
  Future editTaskToDB(Todo todo) async {
    if (addTodoText.isEmpty) {
      return;
    }
    addingTodoLoading = true;
    try {
      await todosRef.doc(todo.id).update({"todo": addTodoText});
      todos[todo.categoryId]!
          .firstWhere((element) => element.id == todo.id)
          .todo = addTodoText;
      showToast(ToastEnum.success, "Todo Edited");
      todos = ObservableMap.of(todos);
    } catch (e) {
      showToast(ToastEnum.error, "Unable to edit");
    } finally {
      addTodoText = '';
      addingTodoLoading = false;
    }
  }

  @action
  void setTheme(ThemeEnum themeEnum) {
    theme = theme != ThemeEnum.dark ? ThemeEnum.dark : ThemeEnum.light;
  }

  NavStore navStore = NavStore();
  LoginStore loginStore = LoginStore();
}
