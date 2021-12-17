import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/entity/user.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/pages/user_info.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/token.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';

//  Divider(height: 1.0), // 分割线

class UserPage extends StatefulWidget {
  final int userId;

  const UserPage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? _user;
  final List<Idea> _list = [];
  int total = 0;
  int page = 1, pageSize = 10;

  ImageProvider getImage() {
    // return AssetImage(UserHolder.blankUser.avatar);
    if (_user == null || _user!.id == 0) {
      return AssetImage(UserHolder.blankUser.avatar);
    }
    return CachedNetworkImageProvider(baseUrl + _user!.avatar);
  }

  Future<void> getUser() async {
    User u = await UserHolder.getUser(widget.userId);
    setState(() {
      _user = u;
    });
  }

  Future<void> getSelfIdea() async {
    final re = await post(
        "/idea/get_idea_list", {"page": page, "pageSize": pageSize,"userId":widget.userId,});
    if (re.statusCode == 200 && re.data["code"] == 0) {
      page++;
      setState(() {
        total = re.data["data"]["total"];
        for (var e in (re.data["data"]["list"] as List)) {
          _list.add(json2Idea(e));
        }
      });
    }
  }

  Future<void> followAct() async {
    if (_user == null) return;
    String path = "", result = "";
    if (_user!.isFollow) {
      path = "/user/delete_follow";
      result = "取消关注成功";
    } else {
      path = "/user/create_follow";
      result = "关注成功";
    }
    final re = await post(path, {"followedId": widget.userId});
    if (re.statusCode == 200 && re.data["code"] == 0) {
      setState(() {
        _user!.isFollow = !_user!.isFollow;
      });
      Fluttertoast.showToast(
        msg: result,
      );
    } else {
      Fluttertoast.showToast(
        msg: "操作失败!",
      );
    }
  }

  bool isSameDay(int index) {
    if (index <= 0) return false;
    if (_list[index].createdAt.year == _list[index - 1].createdAt.year &&
        _list[index].createdAt.month == _list[index - 1].createdAt.month &&
        _list[index].createdAt.day == _list[index - 1].createdAt.day) {
      return true;
    }
    return false;
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
      // color: Colors.blueGrey,·
      child: Column(
        children: [
          Container(
            height: 280,
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
                widget.userId == selfID || widget.userId == 0
                    ? Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(10.0),
                              // height: 20.0,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const UserInfo(),
                                  ));
                                },
                                child: const Text(
                                  "编辑资料",
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
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(10.0),
                              // height: 20.0,
                              child: TextButton(
                                onPressed: followAct,
                                child: _user != null && _user!.isFollow
                                    ? const Text(
                                        "取消关注",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
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
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          _list.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "暂无Idea",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
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
                              isSameDay(index)
                                  ? Container()
                                  : Row(
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
                                                  .format(
                                                      _list[index].createdAt)
                                                  .toString() +
                                              "月",
                                          style: DefaultTextStyle.of(context)
                                              .style
                                              .copyWith(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                        ),
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
                      connectorBuilder: (_, index, ___) =>
                          const DashedLineConnector(),
                    ),
                  ),
                ),
          _list.length < total
              ? Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: TextButton(
                    onPressed: () {
                      getSelfIdea();
                    },
                    child: const Text(
                      "加载更多",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(8, 4, 8, 4)),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.black, width: 1)),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
