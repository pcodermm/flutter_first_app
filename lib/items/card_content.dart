import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final int page;
  final GlobalKey<FormState> formKey;
  final void Function(String?)? onNameSaved;
  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  final String iniV;
  const CardContent({
    super.key,
    required this.page,
    required this.formKey,
    this.onNameSaved,
    this.onEmailSaved,
    this.onPasswordSaved,
    required this.iniV,
  });

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Step 1',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Image.asset(
              'assets/images/id-card.gif',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 5),
            const Text(
              'Enter your full name below',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: TextFormField(
                initialValue: iniV,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  labelText: 'Enter your full name here',
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: onNameSaved,
              ),
            ),
          ],
        );

      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Step 2',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Image.asset(
              'assets/images/email-marketing.gif',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 5),
            const Text(
              'Enter your email address below',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: TextFormField(
                initialValue: iniV,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Enter your email address here',
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email or phone number is required';
                  } else if (!value.contains('@gmail.com')) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                onSaved: onEmailSaved,
              ),
            ),
          ],
        );

      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Step 3',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Image.asset(
              'assets/images/two-step-verification.gif',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 5),
            const Text(
              'Enter your password below',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: TextFormField(
                initialValue: iniV,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'Enter password here',
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'password is required';
                  } else if (value.length < 8) {
                    return 'password must be at least 8 characters';
                  }
                  return null;
                },
                onSaved: onPasswordSaved,
              ),
            ),
          ],
        );

      default:
        return const Text('Error: Page not found');
    }
  }
}
