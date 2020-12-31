import 'package:charity_app/view/admin_list_pg.dart';
import 'package:charity_app/view/login_page.dart';
import 'package:charity_app/view/profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Charity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/userInfo': (context) => UsersInfoList(),
        '/listpage': (context) => ListScreen(),
        '/login': (context) => LoginScreen(),
      },
      home: LoginScreen(),
    );
  }
}
