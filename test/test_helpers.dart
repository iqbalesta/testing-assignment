import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void setupTestDb() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}
