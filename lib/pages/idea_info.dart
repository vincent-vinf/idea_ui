import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea/entity/comment.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/time_string.dart';

import 'comment_part.dart';

class IdeaInfo extends StatefulWidget {
  final bool? withComment;
  final Idea idea;

  const IdeaInfo({Key? key, required this.idea, this.withComment})
      : super(key: key);

  @override
  _IdeaInfoState createState() => _IdeaInfoState();
}

class _IdeaInfoState extends State<IdeaInfo> {
  bool doOnce = false;

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

      setState(() {
        widget.idea.comments = tmp;
      });

      if (!doOnce) {
        if (widget.withComment != null && widget.withComment == true) {
          editPostComment(widget.idea.id, 0, 0);
        }
        doOnce = !doOnce;
      }
    }
  }

  postSelfComment(int id) {
    editPostComment(id, 0, 0);
  }

  Future<void> editPostComment(int ideaId, int toId, int commentId) async {
    final text = await showCommentDialog();
    if (text != null && text.isNotEmpty) {
      final re = await postComment(ideaId, toId, commentId, text);
      if (re) {
        Fluttertoast.showToast(
          msg: "评论成功",
        );
        // 评论成功后刷新数据
        getData();
      } else {
        Fluttertoast.showToast(
          msg: "评论失败!",
        );
      }
    }
  }

  Future<String?> showCommentDialog() async {
    final textList = await showTextInputDialog(
      okLabel: "确定",
      cancelLabel: "取消",
      context: context,
      textFields: const [
        DialogTextField(maxLines: 3, hintText: "评论"),
      ],
    );
    if (textList == null) {
      return null;
    }
    if (textList[0].isEmpty) {
      Fluttertoast.showToast(
        msg: "评论不能为空!",
      );
    }
    // print(textList);
    return textList[0];
  }

  Future<bool> postComment(
      int ideaId, int toId, int commentId, String content) async {
    final re = await post("/idea/create_comment", {
      "ideaId": ideaId,
      "toId": toId,
      "commentId": commentId,
      "content": content
    });

    if (re.statusCode == 200 && re.data["code"] == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.idea.comments.length);

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
              commentFunc: postSelfComment,
            ),
            Text(
              diffTime(DateTime.now().difference(widget.idea.createdAt)),
              style: const TextStyle(color: Colors.grey),
            ),
            widget.idea.comments.isEmpty
                ? Container(
                    child: const Text(
                      "暂无评论",
                      style: TextStyle(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.all(10),
                  )
                : Container(
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
        onTapFunc: editPostComment,
        callRefresh: getData,
        fatherId: 0,
      ));
    }
    return list;
  }
}
