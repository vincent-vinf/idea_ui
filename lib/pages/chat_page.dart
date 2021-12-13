import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(right: 160),
            child: TabBar(tabs: [
              Tab(
                text: "通知",
              ),
              Tab(
                text: "聊天",
              ),
            ]),
          ),
        ),
        body: const TabBarView(children: [
          Center(child: Text('通知')),
          Center(child: Text('聊天')),
        ]),
      ),
    );
  }
}
