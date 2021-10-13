import 'package:faker/faker.dart';
import 'package:floor_db_flutter/dao/EmployeeDao.dart';
import 'package:floor_db_flutter/database/database.dart';
import 'package:floor_db_flutter/entity/Employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('nisha_database.db').build();
  final dao = database.employeeDao;
  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final EmployeeDao? dao;

  MyApp({this.dao});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.dao});

  final EmployeeDao? dao;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Room Database'),
        actions: [
          IconButton(
              onPressed: () async {
                final employee = Employee(
                    firstName: Faker().person.firstName(),
                    lastName: Faker().person.lastName(),
                    email: Faker().internet.email());
                await widget.dao!.insertEmployee(employee);
                showSnackBar(scaffoldKey.currentState, 'Add Success');
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                widget.dao!.deleteAllEmployee();
                setState(
                    (){
                      showSnackBar(scaffoldKey.currentState, 'Clear Success');
                    }
                );
              },
              icon: Icon(Icons.clear)),
        ],
      ),
      body: StreamBuilder(
        stream: widget.dao!.getAllEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: (Text('${snapshot.error}')));
          } else if (snapshot.hasData) {
            var listEmployee = snapshot.data as List<Employee>;
            return Container(
              color: Colors.black12,
              padding: EdgeInsets.all(0),
              child: ListView.builder(
                itemCount: listEmployee != null ? listEmployee.length : 0,
                  itemBuilder: (context, index) {
                return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Update',
                        color: Colors.pink,
                        icon: Icons.update,
                        onTap: () async{
                          final updateEmployee = listEmployee[index];
                          updateEmployee.firstName = Faker().person.firstName();
                          updateEmployee.lastName = Faker().person.lastName();
                          updateEmployee.email = Faker().internet.email();

                          await widget.dao!.updateEmployee(updateEmployee);

                          showSnackBar(scaffoldKey.currentState, 'Updated');

                        },
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async{
                          final deleteEmployee = listEmployee[index];
                          await widget.dao!.deleteEmployee(deleteEmployee);
                          showSnackBar(scaffoldKey.currentState, 'Deleted');
                        },
                      )
                    ],
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20),
                      tileColor: Colors.black12,
                      title: Text('${listEmployee[index].firstName} ${listEmployee[index].lastName}', style: TextStyle(color: Colors.black, fontSize: 18),),
                      subtitle: Text('${listEmployee[index].email}', style: TextStyle(color: Colors.black, fontSize: 14)),
                    ));
              }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

void showSnackBar(ScaffoldState? currentState, String s) {
  final snackBar = SnackBar(
    content: Text(s),
        duration: Duration(seconds: 1),
  );
  currentState!.showSnackBar(snackBar);
}
