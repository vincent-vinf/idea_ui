import 'package:flutter/material.dart';
import 'package:idea/pages/edit_page.dart';
import 'package:idea/pages/home_page.dart';
import 'package:idea/pages/login.dart';
import 'package:idea/pages/sort_page.dart';
import 'package:idea/pages/user_page.dart';
import 'package:idea/util/token.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isValidToken() ? const MyNavigationBar() : const LoginScreen(),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyNavigationBarState();
  }
}

class MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SortPage(),
    Align(
      alignment: Alignment.center,
      child: Text("chat\ntodo"),
    ),
    UserPage(),
  ];

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IconButton(
        padding: const EdgeInsets.all(0),
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        icon: const Image(
          image: AssetImage('assets/image/add.png'),
        ),
        iconSize: 70,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EditPage();
            }),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  updateTabSelection(0);
                },
                padding: const EdgeInsets.all(3),
                icon: const Image(
                  image: AssetImage('assets/image/home.png'),
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(1);
                },
                padding: const EdgeInsets.all(3),
                icon: const Image(
                  image: AssetImage('assets/image/tag.png'),
                ),
              ),
              const SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(2);
                },
                padding: const EdgeInsets.all(3),
                icon: const Image(
                  image: AssetImage('assets/image/chat.png'),
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(3);
                },
                padding: const EdgeInsets.all(3),
                icon: const Image(
                  image: AssetImage('assets/image/user.png'),
                ),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
      ),
    );
  }
}
