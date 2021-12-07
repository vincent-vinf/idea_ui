import 'package:flutter/material.dart';

class IdeaInfo extends StatefulWidget {
  const IdeaInfo({Key? key}) : super(key: key);

  @override
  _IdeaInfoState createState() => _IdeaInfoState();
}

class _IdeaInfoState extends State<IdeaInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("idea"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blue,
        elevation: 50.0,
      ),
      body: Text("safs"),
    );
  }
}
