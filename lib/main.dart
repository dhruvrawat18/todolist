import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task_data.dart';
import 'screens/tasks_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.varelaTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: TasksScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
