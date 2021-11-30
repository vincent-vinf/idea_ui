import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/entity/user.dart';

class IdeaCard extends StatefulWidget {
  final Idea idea;

  const IdeaCard({Key? key, required this.idea}) : super(key: key);

  @override
  _IdeaCardState createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard> {
  bool isClick = true;

  @override
  Widget build(BuildContext context) {
    User user = getUser(widget.idea.userId);
    const double buttonSize = 32;
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      showImage: true,
      title: GFListTile(
        avatar: GFAvatar(
          backgroundImage: AssetImage(user.avatar),
          size: GFSize.SMALL,
        ),
        onTap: () {
          print("tap user");
        },
        titleText: user.name,
        // subTitle: Text("dad"),
        padding: const EdgeInsets.all(0),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      // margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      content: Column(
        children: [
          Text(widget.idea.summary),
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
                          onPressed: () {
                            print("123");
                          },
                          padding: const EdgeInsets.all(0),
                          icon: const Image(
                            image: AssetImage('assets/image/heart.png'),
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
                      isClick = ! isClick;
                    });
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    foregroundDecoration: null,
                    child: Image(
                      image: isClick
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
                  onPressed: () {
                    print("3");
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
