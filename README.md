# floor_db_flutter

Floor database.

## Getting Started

The floor database which is the abstract class of sqflite database.

  > First of all we add dependencies inside pubspec.yaml  under dependencies:

              floor: ^1.2.0
              flutter_slidable: ^0.6.0
              faker: ^2.0.0

  > Then we add two more dependency under dev_dependency:

              floor_generator: ^1.2.0
              build_runner: ^2.1.4

  > We have to run a command in terminal after code of such files like main.dart, daṭabase.dart, dao.dart, entity file etc.

              flutter packages pub run build_runner build

             // After this command it will generate the database.g.dart file which is used to run the queries.

  > In this we will perform CRUD methods using floor:
              
              .. Create
              .. Insert
              .. Delete
              .. Update
             
  Thanks....           
