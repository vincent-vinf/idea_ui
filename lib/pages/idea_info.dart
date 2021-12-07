import 'package:flutter/material.dart';
import 'package:idea/entity/comment.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';

import 'comment_page.dart';

class IdeaInfo extends StatefulWidget {
  final int id;

  const IdeaInfo({Key? key, required this.id}) : super(key: key);

  @override
  _IdeaInfoState createState() => _IdeaInfoState();
}

class _IdeaInfoState extends State<IdeaInfo> {
  Idea? _idea;

  Future<void> getData() async {
    final re = await post("/idea/get_idea_info", {"id": widget.id});
    if (re.statusCode == 200 && re.data["code"] == 0) {
      Idea tmp = json2Idea(re.data["data"]);
      for (int i = 0; i < re.data["data"]["comments"]["num"]; i++) {
        tmp.comments.add(json2Comment(re.data["data"]["comments"]["list"][i]));
      }
      setState(() {
        _idea = tmp;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("idea"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     tooltip: 'Setting Icon',
        //     onPressed: () {},
        //   ),
        // ],

        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        elevation: 50.0,
      ),
      body: _idea == null
          ? Container()
          : SingleChildScrollView(
            child: Column(
                children: [
                  IdeaCard(idea: _idea!, isMarkdown: true),
                  Column(
                    children: buildComments(),
                  ),
                ],
              ),
          ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       _idea == null
      //           ? IdeaCard(idea: Idea.blankIdea, isMarkdown: true)
      //           : IdeaCard(idea: _idea!, isMarkdown: true),
      //       Column(
      //         children: buildComments(),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  List<Widget> buildComments() {
    List<Widget> list = [];
    if (_idea == null) return list;
    for (Comment c in _idea!.comments) {
      list.add(CommentPart(comment: c));
    }
    return list;
  }
}
