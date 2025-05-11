import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveBox {
  Future<void> initFlutter();

  Future<Box<T>> openBox<T>(String name);

  Future<void> closeBox();
}

class HiveBoxImpl extends HiveBox {
  HiveBoxImpl(this._hive);
  final HiveInterface _hive;

  @override
  Future<void> initFlutter() async {
    await _hive.initFlutter();
  }

  @override
  Future<Box<T>> openBox<T>(String name) async {
    return _hive.openBox(name);
  }

  @override
  Future<void> closeBox() async {
    await _hive.close();
  }
}
