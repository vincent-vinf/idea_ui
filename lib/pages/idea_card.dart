import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/util/request.dart';
import 'package:markdown_widget/markdown_widget.dart';

class IdeaCard extends StatefulWidget {
  final Idea idea;
  final bool isMarkdown;
  final Function? func;

  const IdeaCard(
      {Key? key, required this.idea, required this.isMarkdown, this.func})
      : super(key: key);

  @override
  _IdeaCardState createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard>
    with SingleTickerProviderStateMixin {
  User? user;

  AssetImage lifeImage(double life) {
    if (life <= 0) {
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
    if (user == null) return AssetImage(UserHolder.blankUser.avatar);
    print(user!.avatar);
    return CachedNetworkImageProvider(baseUrl + user!.avatar);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 32;
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      // padding: EdgeInsets.only(bottom: 0),
      showImage: true,
      title: GFListTile(
        avatar: GFAvatar(
          // backgroundImage: AssetImage(
          //     user == null ? UserHolder.blankUser.avatar : user!.avatar),
          backgroundImage: getImage(),
          size: GFSize.SMALL,
        ),
        onTap: () {
          debugPrint("tap user");
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
              : Text(widget.idea.summary),
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
                      Text(widget.idea.life.floor().toString())
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 26,
                width: 26,
                child: IconButton(
                  splashRadius: 30,
                  onPressed: () {
                    setState(() {
                      widget.idea.isLike = !widget.idea.isLike;
                    });
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    foregroundDecoration: null,
                    child: Image(
                      image: widget.idea.isLike
                          ? const AssetImage('assets/image/like2.png')
                          : const AssetImage('assets/image/like2_empty.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: buttonSize,
                width: buttonSize,
                child: IconButton(
                  // onPressed: () {
                  //   showFloatingModalBottomSheet(
                  //     context: context,
                  //     builder: (context) => Container(
                  //       child: TextField(
                  //         autofocus: true,
                  //         decoration: InputDecoration(
                  //             labelText: "用户名",
                  //             hintText: "用户名或邮箱",
                  //             prefixIcon: Icon(Icons.person)),
                  //       ),
                  //     ),
                  //   );
                  // },
                  onPressed: () {
                    if (widget.func != null) widget.func!(widget.idea.id);
                  },
                  splashRadius: buttonSize,
                  padding: const EdgeInsets.all(0),
                  icon: const Image(
                    image: AssetImage('assets/image/comment.png'),
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
