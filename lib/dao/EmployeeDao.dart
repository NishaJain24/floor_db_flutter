import 'dart:core';
import 'package:floor/floor.dart';
import 'package:floor_db_flutter/entity/Employee.dart';

@dao
abstract class EmployeeDao{
  @Query('SELECT * FROM Employee')
  Stream<List<Employee>> getAllEmployee();

  @Query('SELECT * FROM Employee WHERE id = :id')
  Stream<Employee?> getAllEmployeeBYID(int id);

  @Query('DELETE FROM Employee')
  Future<void> deleteAllEmployee();

  @insert
  Future<void> insertEmployee(Employee employee);

  @update
  Future<void> updateEmployee(Employee employee);

  @delete
  Future<void> deleteEmployee(Employee employee);
}