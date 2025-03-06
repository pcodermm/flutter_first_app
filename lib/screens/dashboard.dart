import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String? name;
  final String? email;
  final String? password;

  const SecondScreen({super.key, this.name, this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Password: $password'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the first screen
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
