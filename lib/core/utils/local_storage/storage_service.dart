import 'package:hive/hive.dart';

mixin StorageH {
  static const authKey = 'authKey';

  // static void openAuthBox() async {
  //   logger.d('before open box');
  //   await Hive.openBox<bool>(StorageH.authKey);
  // }
}

class StorageService {
  static final StorageService _storege = StorageService._();

  factory StorageService() {
    return _storege;
  }

  StorageService._();

  // openAuthBox() async {
  //   return await Hive.openBox<bool>(StorageH.authKey);
  // }

  Box<bool> getAuthBox() => Hive.box<bool>(StorageH.authKey);
}


