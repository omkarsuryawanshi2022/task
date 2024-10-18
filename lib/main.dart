import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/user_provider.dart';
import 'views/user_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider()..fetchUsers(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: UserListScreen(),
    );
  }
}
