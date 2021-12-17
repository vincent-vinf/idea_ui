import 'package:flutter/material.dart';
import 'package:idea/pages/message/chat_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
                child: Text(
                  "通知",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "聊天",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ),
          // backgroundColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body: const TabBarView(children: [
          Center(child: Text('通知')),
          ChatPage(),
        ]),
      ),
    );
  }
}
