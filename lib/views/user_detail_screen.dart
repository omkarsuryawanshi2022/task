import 'package:flutter/material.dart';
import 'package:task/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

   UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(user.picture, height: 200, width: 200),
            ),
            const SizedBox(height: 16),
            Text('ID: ${user.id}', style: const TextStyle(fontSize: 18)),
            Text('Name: ${user.title} ${user.firstName} ${user.lastName}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
