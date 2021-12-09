import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:idea/entity/comment.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/time_string.dart';

import 'comment_page.dart';

class IdeaInfo extends StatefulWidget {
  final bool? withComment;
  final Idea idea;

  const IdeaInfo({Key? key, required this.idea, this.withComment})
      : super(key: key);

  @override
  _IdeaInfoState createState() => _IdeaInfoState();
}

class _IdeaInfoState extends State<IdeaInfo> {
  Future<void> getData() async {
    final re = await post("/idea/get_idea_info", {"id": widget.idea.id});
    if (re.statusCode == 200 && re.data["code"] == 0) {
      final List<Comment> tmp = [];
      for (var e in (re.data["data"]["comments"] as List)) {
        Comment c = json2Comment(e);
        List<Comment> replys = [];
        for (var r in (e["replys"] as List)) {
          replys.add(json2Comment(r));
        }
        c.reply = replys;
        tmp.add(c);
      }

      widget.idea.comments = tmp;

      setState(() {
        if (widget.withComment != null && widget.withComment == true) {
          showCommentDialog(widget.idea.id);
        }
      });
    }
  }

  void showCommentDialog(int id) async {
    final text = await showTextInputDialog(
      context: context,
      textFields: const [
        DialogTextField(maxLines: 3, hintText: "评论"),
      ],
    );
    print(text);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.idea.comments.length);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            IdeaCard(
              idea: widget.idea,
              isMarkdown: true,
              commentFunc: showCommentDialog,
            ),
            Text(
              diffTime(DateTime.now().difference(widget.idea.createdAt)),
              style: const TextStyle(color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: buildComments(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildComments() {
    List<Widget> list = [];
    for (Comment c in widget.idea.comments) {
      list.add(CommentPart(
        comment: c,
        withReply: true,
      ));
    }
    return list;
  }
}
