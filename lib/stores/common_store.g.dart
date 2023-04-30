// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommonStore on _CommonStore, Store {
  late final _$pageAtom = Atom(name: '_CommonStore.page', context: context);

  @override
  Pages get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(Pages value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$counterAtom =
      Atom(name: '_CommonStore.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$typeAtom = Atom(name: '_CommonStore.type', context: context);

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$type2Atom = Atom(name: '_CommonStore.type2', context: context);

  @override
  String get type2 {
    _$type2Atom.reportRead();
    return super.type2;
  }

  @override
  set type2(String value) {
    _$type2Atom.reportWrite(value, super.type2, () {
      super.type2 = value;
    });
  }

  late final _$_CommonStoreActionController =
      ActionController(name: '_CommonStore', context: context);

  @override
  void setPage(Pages p) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setPage');
    try {
      return super.setPage(p);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reload() {
    final _$actionInfo =
        _$_CommonStoreActionController.startAction(name: '_CommonStore.reload');
    try {
      return super.reload();
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
counter: ${counter},
type: ${type},
type2: ${type2}
    ''';
  }
}
