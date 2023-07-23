// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NavStore on _NavStore, Store {
  Computed<int>? _$selectedScreenIndexComputed;

  @override
  int get selectedScreenIndex => (_$selectedScreenIndexComputed ??=
          Computed<int>(() => super.selectedScreenIndex,
              name: '_NavStore.selectedScreenIndex'))
      .value;

  late final _$screenAtom = Atom(name: '_NavStore.screen', context: context);

  @override
  Screen get screen {
    _$screenAtom.reportRead();
    return super.screen;
  }

  @override
  set screen(Screen value) {
    _$screenAtom.reportWrite(value, super.screen, () {
      super.screen = value;
    });
  }

  late final _$_NavStoreActionController =
      ActionController(name: '_NavStore', context: context);

  @override
  void setScreen(Screen s) {
    final _$actionInfo =
        _$_NavStoreActionController.startAction(name: '_NavStore.setScreen');
    try {
      return super.setScreen(s);
    } finally {
      _$_NavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screen: ${screen},
selectedScreenIndex: ${selectedScreenIndex}
    ''';
  }
}
