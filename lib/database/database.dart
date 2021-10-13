
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:floor_db_flutter/dao/EmployeeDao.dart';
import 'package:floor_db_flutter/entity/Employee.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase{
  EmployeeDao get employeeDao;

}