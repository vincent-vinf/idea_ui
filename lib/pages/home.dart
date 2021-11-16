import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
