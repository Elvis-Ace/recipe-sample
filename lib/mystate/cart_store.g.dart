// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  late final _$totalAtom = Atom(name: '_CartStore.total', context: context);

  @override
  String get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(String value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$_CartStoreActionController =
      ActionController(name: '_CartStore', context: context);

  @override
  void addToCart(Product item) {
    final _$actionInfo =
        _$_CartStoreActionController.startAction(name: '_CartStore.addToCart');
    try {
      return super.addToCart(item);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(Product item) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.removeFromCart');
    try {
      return super.removeFromCart(item);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
total: ${total}
    ''';
  }
}
