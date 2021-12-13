import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/pages/user_page.dart';
import 'package:idea/util/request.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';

class IdeaCard extends StatefulWidget {
  final Idea idea;
  final bool isMarkdown;
  final Function? commentFunc;
  final bool? onlyText, disableLike;
  final double? fixHeight;

  const IdeaCard(
      {Key? key,
      required this.idea,
      required this.isMarkdown,
      this.commentFunc,
      this.onlyText,
      this.disableLike,
      this.fixHeight})
      : super(key: key);

  @override
  _IdeaCardState createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard>
    with SingleTickerProviderStateMixin {
  User? user;

  AssetImage lifeImage(double life) {
    // print("life: " + life.toString());
    if (life <= 0.5) {
      return const AssetImage('assets/image/life0.png');
    } else if (life < 20) {
      return const AssetImage('assets/image/life20.png');
    } else if (life < 50) {
      return const AssetImage('assets/image/life50.png');
    } else {
      return const AssetImage('assets/image/life100.png');
    }
  }

  Future<void> getUser() async {
    user = await UserHolder.getUser(widget.idea.userId);
    setState(() {});
  }

  ImageProvider getImage() {
    // return AssetImage(UserHolder.blankUser.avatar);
    if (user == null || user!.id == 0) {
      return AssetImage(UserHolder.blankUser.avatar);
    }
    // print(user!.avatar);
    return CachedNetworkImageProvider(baseUrl + user!.avatar);
  }

  void changeLike() async {
    String path = "";
    if (widget.idea.isLike) {
      path = "/idea/delete_like";
    } else {
      path = "/idea/create_like";
    }
    final re = await post(path, {"ideaId": widget.idea.id});
    if (re.statusCode == 200 && re.data["code"] == 0) {
      setState(() {
        widget.idea.isLike = !widget.idea.isLike;
      });
      debugPrint("点赞:" + widget.idea.isLike.toString());
    } else {
      debugPrint("点赞/取消，失败！");
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 32;
    if (user != null && widget.idea.userId != user!.id) {
      getUser();
    }
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      showImage: true,
      title: widget.onlyText != null && widget.onlyText == true
          ? null
          : GFListTile(
              avatar: GFAvatar(
                // backgroundImage: AssetImage(
                //     user == null ? UserHolder.blankUser.avatar : user!.avatar),
                backgroundImage: getImage(),
                size: GFSize.SMALL,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(50.0),
                        child: AppBar(
                          backgroundColor: Colors.white,
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      body: UserPage(
                        userId: widget.idea.userId,
                      ),
                    );
                  }),
                );
              },
              titleText: user == null ? UserHolder.blankUser.name : user!.name,
              // subTitle: Text("dad"),
              padding: const EdgeInsets.all(0),
            ),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isMarkdown
              ? Column(
                  children:
                      MarkdownGenerator(data: widget.idea.content).widgets!,
                )
              : SizedBox(
                  height: widget.fixHeight, child: Text(widget.idea.summary)),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      SizedBox(
                        height: buttonSize,
                        width: buttonSize,
                        child: IconButton(
                          splashRadius: buttonSize,
                          onPressed: null,
                          padding: const EdgeInsets.all(0),
                          icon: Image(
                            image: lifeImage(widget.idea.life),
                          ),
                        ),
                      ),
                      Text(widget.idea.life.toStringAsFixed(1))
                    ],
                  ),
                ),
              ),
              (widget.onlyText != null && widget.onlyText == true) ||
                      (widget.disableLike != null && widget.disableLike == true)
                  ? Text(
                      DateFormat("hh:mm").format(widget.idea.createdAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  : SizedBox(
                      height: 26,
                      width: 26,
                      child: IconButton(
                        splashRadius: 30,
                        onPressed: changeLike,
                        padding: const EdgeInsets.all(0),
                        icon: Container(
                          foregroundDecoration: null,
                          child: Image(
                            image: widget.idea.isLike
                                ? const AssetImage('assets/image/like2.png')
                                : const AssetImage(
                                    'assets/image/like2_empty.png'),
                          ),
                        ),
                      ),
                    ),
              widget.commentFunc == null
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        height: buttonSize,
                        width: buttonSize,
                        child: IconButton(
                          onPressed: () {
                            if (widget.commentFunc != null) {
                              widget.commentFunc!(widget.idea.id);
                            }
                          },
                          splashRadius: buttonSize,
                          padding: const EdgeInsets.all(0),
                          icon: const Image(
                            image: AssetImage('assets/image/comment.png'),
                          ),
                        ),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
