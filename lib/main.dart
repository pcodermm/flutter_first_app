import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  String? _name;
  String? _email;
  String? _password;
  final PageController _pageController = PageController();
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),*/
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/light-1.png'),
                Image.asset('assets/images/light-2.png'),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset('assets/images/clock.png'),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            _page = value;
                          });
                        },
                        controller: _pageController,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CardContent(
                                  page:
                                      index, // Use index here instead of _page
                                  formKey: _formKeys[index],
                                  onNameSaved: (value) {
                                    setState(() {
                                      _name = value;
                                    });
                                  },
                                  onEmailSaved: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                  },
                                  onPasswordSaved: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _page == 0
                                ? null // Disable the button if on the first page
                                : () {
                                    _page--; // Move to the previous page
                                    setState(() {
                                      _pageController.jumpToPage(
                                          _page); // Update the PageView
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                            ),
                            child: const Text(
                              'Prev',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _page == 2
                                ? () {
                                    if (_formKeys[_page].currentState != null &&
                                        _formKeys[_page]
                                            .currentState!
                                            .validate()) {
                                      _formKeys[_page]
                                          .currentState!
                                          .save(); // Save the form data
                                      print(
                                          'Name: $_name, Email: $_email, Password: $_password');
                                    }
                                  }
                                : () {
                                    if (_formKeys[_page].currentState != null &&
                                        _formKeys[_page]
                                            .currentState!
                                            .validate()) {
                                      _formKeys[_page]
                                          .currentState!
                                          .save(); // Save the form data
                                      _page++;

                                      // Move to the next page
                                      setState(() {
                                        _pageController.jumpToPage(_page);
                                      });
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final int page;
  final GlobalKey<FormState> formKey;
  final void Function(String?)? onNameSaved;
  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  const CardContent({
    super.key,
    required this.page,
    required this.formKey,
    this.onNameSaved,
    this.onEmailSaved,
    this.onPasswordSaved,
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
