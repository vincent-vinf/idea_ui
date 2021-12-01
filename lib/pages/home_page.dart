import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/space_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GeeksforGeeks"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.blue,
        elevation: 50.0,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: EasyRefresh.custom(
          header: SpaceHeader(),
          footer: BezierBounceFooter(),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _count = 20;
                });
              }
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _count += 20;
                });
              }
            });
          },
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return IdeaCard(idea: Idea(1, 1, "summary", "content", 1024));
                },
                childCount: _count,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
