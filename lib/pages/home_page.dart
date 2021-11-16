import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String test = "123";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      padding: EdgeInsets.only(top: 100),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(test),
            TextButton(
              onPressed: () {
                setState(() {
                  test = "hhh";
                });
              },
              child: Text("click"),
            )
          ],
        ),
      ),
    );
  }
}
