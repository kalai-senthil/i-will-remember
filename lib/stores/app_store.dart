import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remainder/db/getters.dart';
import 'package:remainder/db/setters.dart';
import 'package:remainder/main.dart';
import 'package:remainder/models/calwise_view.dart';
import 'package:remainder/models/remainder.dart';
import 'package:remainder/models/todo.dart';
import 'package:remainder/stores/login_store.dart';
import 'package:remainder/stores/nav_store.dart';
import 'package:remainder/models/categories.dart';
import 'package:file_picker/file_picker.dart';
import 'package:alarm/alarm.dart';
import 'package:remainder/ui/toast_animation.dart';
import 'package:remainder/utils.dart';
part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

enum ThemeEnum { light, dark, system }

enum ToastEnum { error, success }

enum DateViewEnum { next, prev, now }

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
      navStore.setScreen(Screen.home);
      isLoggedIn = true;
      this.user = user;
      runAfterLogin();
    });
  }
  @observable
  Map<String, List<Remainder>> remainders = {};
  @observable
  @observable
  DateTime selectedDate =
      ((DateTime d) => DateTime(d.year, d.month))(DateTime.now());
  @computed
  String get selectedMonth => Utils.months[selectedDate.month];
  @observable
  Map<String, List<CalendarWiseView>> calendarView = {};
  @computed
  List<String> get daysToShow {
    DateTime d = DateTime(selectedDate.year, selectedDate.month);
    List<String> daysToShowTemp = [];
    while (d.month == selectedDate.month) {
      daysToShowTemp.add(formatDate(d, [dd]));
      d = d.add(const Duration(days: 1));
    }
    return daysToShowTemp;
  }

  @action
  void setSelectedDateToView(DateViewEnum dateViewEnum) {
    switch (dateViewEnum) {
      case DateViewEnum.next:
        selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
        break;
      case DateViewEnum.prev:
        selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
        break;
      case DateViewEnum.now:
        selectedDate = ((d) => DateTime(d.year, d.month))(DateTime.now());
        break;
      default:
    }
    getCalWiseView();
  }

  @observable
  String? calShowViewKey;
  @observable
  bool calWiseViewLoading = true;
  @action
  void setCalShowViewKey(String key) {
    calShowViewKey = key;
  }

  @action
  Future getCalWiseView() async {
    try {
      calWiseViewLoading = true;
      calShowViewKey = null;
      final data = await getCalendarWiseView(
        remaindersRef,
        todosRef,
        userUID,
        selectedDate,
      );
      if (data.isNotEmpty) {
        calShowViewKey = data.keys.first;
      }
      showToast(ToastEnum.success, "Updated");
      calendarView = ObservableMap.of(data);
    } catch (e) {
      showToast(ToastEnum.error, "Error Updating");
    } finally {
      calWiseViewLoading = false;
    }
  }

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
      if (state) {
        final remainder = remainders[categoryId]![index];
        await Alarm.set(
          alarmSettings: AlarmSettings(
            id: remainder.alarmId,
            dateTime: remainder.time,
            assetAudioPath: remainder.tone,
          ),
        );
      } else {
        await Alarm.stop(remainders[categoryId]![index].alarmId);
      }
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
      player.onPlayerComplete.listen((event) {
        playing = false;
      });
      final categories = await getCategories(categoriesRef, userUID);
      this.categories = ObservableList.of(categories);
      getCalWiseView();
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
  Future setRemainderTone() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["mp3"],
        withData: true,
        withReadStream: true,
      );
      if (result != null && result.files.isNotEmpty) {
        String docPath = (await getApplicationDocumentsDirectory()).path;
        PlatformFile file = result.files.single;
        File _file = await File("$docPath/${file.name}").writeAsBytes(
            file.bytes!.toList(),
            flush: true,
            mode: FileMode.write);
        remainderTone = _file.path;
        showToast(ToastEnum.success, "File Selected");
      } else {
        showToast(ToastEnum.error, "Selection Cancelled");
      }
    } catch (e) {
      print(e);
      showToast(ToastEnum.error, "Error Loading File");
    }
  }

  @action
  Future updateTodo(Todo todo, {required bool state}) async {
    try {
      await updateDoc(todosRef.doc(todo.id), {"completed": state});
      todos[todo.categoryId]!
          .firstWhere((element) => element.id == todo.id)
          .completed = state;
      todos = ObservableMap.of(todos);
      showToast(ToastEnum.success, "Todo Updated");
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

  final player = AudioPlayer();
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
  Future togglePlay() async {
    try {
      if (playing) {
        player.stop();
        playing = false;
      } else {
        playing = true;
        if (remainderTone.contains("assets")) {
          await player.play(AssetSource(remainderTone.substring(7)));
        } else {
          await player.play(DeviceFileSource(remainderTone));
        }
      }
    } catch (e) {
      playing = false;
      showToast(ToastEnum.error, "Error Playing");
    }
  }

  @observable
  String remainderTone = "assets/alarm.mp3";
  @observable
  bool playing = false;
  @action
  Future<bool> addTask() async {
    try {
      if (selectedCategory == null || addTaskText == null) {
        return false;
      }
      addingRemainder = true;
      final alarmId = remaindersRef.doc().id.hashCode;
      final taskDoc = await addRemainderToDB(remaindersRef, {
        "task": addTaskText,
        "createdAt": FieldValue.serverTimestamp(),
        "time": addRemainderDateAndTime,
        "days": addRemainderDays,
        "categoryId": selectedCategory,
        "enabled": true,
        "userId": userUID,
        "tone": remainderTone,
        "alarmId": alarmId
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
          "tone": remainderTone,
          "alarmId": alarmId
        },
      );
      if (remainders.containsKey(selectedCategory)) {
        remainders[selectedCategory]!.add(taskToAdd);
      } else {
        remainders[selectedCategory!] = [taskToAdd];
      }
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: alarmId,
          dateTime: addRemainderDateAndTime,
          assetAudioPath: remainderTone,
          notificationBody: addTaskText,
          notificationTitle:
              "Remainder ${categories.firstWhere((element) => element.id == selectedCategory).name}",
        ),
      );
      showToast(ToastEnum.success, "Added Successfully");
      return true;
    } catch (e) {
      print(e);
      showToast(ToastEnum.error, "Unable to add Todo");
      return false;
    } finally {
      addingRemainder = false;
      addTaskText = null;
      selectedCategory = null;
      remainderTone = "assets/alarm.mp3";
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
