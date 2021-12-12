import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/entity/user_info.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/token.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';

//  Divider(height: 1.0), // 分割线

class UserPage extends StatefulWidget {
  final int? id;

  const UserPage({Key? key, this.id}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? _user;
  final List<Idea> _list = [Idea.blankIdea, Idea.blankIdea, Idea.blankIdea];

  ImageProvider getImage() {
    // return AssetImage(UserHolder.blankUser.avatar);
    if (_user == null || _user!.id == 0) {
      return AssetImage(UserHolder.blankUser.avatar);
    }
    // print(user!.avatar);
    return CachedNetworkImageProvider(baseUrl + _user!.avatar);
  }

  Future<void> getUser() async {
    if (widget.id == null) {
      _user = await UserHolder.getUser(selfID);
    } else {
      _user = await UserHolder.getUser(widget.id!);
    }
    setState(() {});
  }

  void getSelfIdea() {
    
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getSelfIdea();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // color: Colors.blueGrey,
      child: Column(
        children: [
          Container(
            height: widget.id == null || widget.id == selfID || widget.id == 0
                ? 200
                : 300,
            // color: Colors.white,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/img.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100.0,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(15.0),
                        child: GFAvatar(
                          backgroundImage: getImage(),
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
                        height: 30.0,
                        child: Text(
                          _user == null
                              ? UserHolder.blankUser.name
                              : _user!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                widget.id == null || widget.id == selfID || widget.id == 0
                    ? Container()
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10.0),
                                // height: 20.0,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "关注",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4)),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Colors.white, width: 1)),
                                  ),
                                )),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                nodePosition: 0,
                color: const Color(0xff989898),
                indicatorTheme: const IndicatorThemeData(
                  position: 0,
                  size: 20.0,
                ),
                connectorTheme: const ConnectorThemeData(
                  thickness: 2.5,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: _list.length,
                contentsBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              DateFormat("dd")
                                  .format(_list[index].createdAt)
                                  .toString(),
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat(" MM")
                                      .format(_list[index].createdAt)
                                      .toString() +
                                  "月",
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   DateFormat("MM-dd HH:mm").format(_list[index].createdAt).toString(),
                            //   style: DefaultTextStyle.of(context).style.copyWith(
                            //     fontSize: 18.0,
                            //   ),
                            // ),
                          ],
                        ),
                        IdeaCard(
                          idea: _list[index],
                          isMarkdown: false,
                          onlyText: true,
                        ),
                      ],
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  return DotIndicator(
                    size: 14,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    // color: Color(0xff66c97f),
                  );
                  // return const DotIndicator(
                  //   size: 14,
                  //   // color: Color(0xff66c97f),
                  // );
                },
                connectorBuilder: (_, index, ___) => DashedLineConnector(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
