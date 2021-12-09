import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:idea/entity/comment.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/time_string.dart';

class CommentPart extends StatefulWidget {
  final Comment comment;
  final bool withReply;

  const CommentPart({Key? key, required this.comment, required this.withReply})
      : super(key: key);

  @override
  _CommentPartState createState() => _CommentPartState();
}

class _CommentPartState extends State<CommentPart> {
  User? user;
  User? toUser;

  Future<void> getUser() async {
    user = await UserHolder.getUser(widget.comment.userId);
    setState(() {});
  }

  Future<void> getToUser() async {
    toUser = await UserHolder.getUser(widget.comment.toId);
    setState(() {});
  }

  ImageProvider getImage() {
    if (user == null) return AssetImage(UserHolder.blankUser.avatar);
    // print(user!.avatar);
    return CachedNetworkImageProvider(baseUrl + user!.avatar);
  }

  @override
  void initState() {
    super.initState();
    getUser();
    if (widget.comment.toId != 0) {
      getToUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 0, 10),
      child: Column(
        children: [
          Row(
            children: [
              GFAvatar(
                radius: 15,
                backgroundImage: getImage(),
              ),
              user == null
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        user!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 20,
                  width: 20,
                  child: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      ///TODO 删除自己的评论，拉黑？
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      foregroundDecoration: null,
                      child: const Image(
                        image: AssetImage('assets/image/menu.png'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 4, 0, 0),
            child: Row(
              children: [
                toUser != null
                    ? Text(
                        "@" + toUser!.name + " ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Container(),
                Text(widget.comment.content),
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 7, 0, 0),
            child: Row(
              children: [
                Text(
                  diffTime(DateTime.now().difference(widget.comment.createdAt)),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
          widget.withReply
              ? Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: Column(
                    children: buildReply(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  List<Widget> buildReply() {
    final List<Widget> list = [];
    if (widget.comment.reply == null) return list;
    for (Comment e in widget.comment.reply!) {
      list.add(CommentPart(comment: e, withReply: false));
    }
    return list;
  }
}
