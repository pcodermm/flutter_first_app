import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/dashboard.dart';

import 'items/card_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                      child: PageView(
                        onPageChanged: (value) {
                          setState(() {
                            _page = value;
                          });
                        },
                        controller: _pageController,
                        // itemCount: 3,
                        // itemBuilder: (context, index) {
                        //   return Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Card(
                        //       color: Colors.white,
                        //       elevation: 8,
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(16.0),
                        //         child: CardContent(
                        //           page:
                        //               index, // Use index here instead of _page
                        //           formKey: _formKeys[index],
                        //           onNameSaved: (value) {
                        //             setState(() {
                        //               _name = value;
                        //             });
                        //           },
                        //           onEmailSaved: (value) {
                        //             setState(() {
                        //               _email = value;
                        //             });
                        //           },
                        //           onPasswordSaved: (value) {
                        //             setState(() {
                        //               _password = value;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   );
                        // },
                        children: [
                          for (int index = 0; index < 3; index++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CardContent(
                                    iniV: (index == 0)
                                        ? _name ?? ''
                                        : (index == 1)
                                            ? _email ?? ''
                                            : _password ?? '',
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
                            ),
                        ],
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
                                      _pageController.animateToPage(
                                        _page,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear,
                                      );
                                      /*_pageController.jumpToPage(
                                          _page);*/ // Update the PageView
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SecondScreen(
                                            name: _name,
                                            email: _email,
                                            password: _password,
                                          ),
                                        ),
                                      );
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
                                        _pageController.animateToPage(
                                          _page,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear,
                                        );
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
