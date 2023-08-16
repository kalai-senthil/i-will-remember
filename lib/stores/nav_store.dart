import 'package:mobx/mobx.dart';
part 'nav_store.g.dart';

class NavStore = _NavStore with _$NavStore;

enum Screen {
  home,
  settings,
  login,
}

abstract class _NavStore with Store {
  @observable
  Screen screen = Screen.home;

  @computed
  int get selectedScreenIndex => screen.index;

  @action
  void setScreen(Screen s) {
    screen = s;
  }
}
