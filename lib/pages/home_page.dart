import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/space_header.dart';

import 'idea_info.dart';

/// TODO
/// []点赞数
/// []发布页
/// 主题色

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 7;
  int _count = 0;
  int _total = 0;
  List<Idea> items = [];
  int _selectedIndex = 0;
  String _dataSrc = "/idea/get_idea_list";

  Future<void> getIdeaList(bool isLoad) async {
    if (!isLoad) _count = 0;
    final re = await post(
        _dataSrc, {"page": (_count ~/ _pageSize) + 1, "pageSize": _pageSize});
    List<Idea> tmp = [];
    if (isLoad && _total <= _count) {
      Fluttertoast.showToast(
        msg: "没有更多啦!",
      );
      return;
    }
    if (re.statusCode == 200 && re.data["code"] == 0) {
      setState(() {
        for (var e in (re.data["data"]["list"] as List)){
          tmp.add(json2Idea(e));
        }
        _total = re.data["data"]["total"];
        if (!isLoad) {
          items = tmp;
          _count = tmp.length;
        } else {
          items.addAll(tmp);
          _count += tmp.length;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getIdeaList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("idea"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Setting Icon',
              onPressed: () {},
            ),
          ],
          // backgroundColor: Colors.white70,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,

          // elevation: 6,
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            // color: mcgpalette0,
            color: Colors.blueGrey,
            child: EasyRefresh.custom(
              header: SpaceHeader(),
              footer: BezierBounceFooter(),
              onRefresh: () async {
                await getIdeaList(false);
              },
              onLoad: () async {
                await getIdeaList(true);
              },
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) {
                        return Container(
                          height: 45,
                        );
                      }
                      index--;
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  IdeaInfo(idea: items[index]),
                            ));
                          },
                          child: IdeaCard(
                            idea: items[index],
                            isMarkdown: false,
                            commentFunc: (int id) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => IdeaInfo(
                                  idea: items[index],
                                  withComment: true,
                                ),
                              ));
                            },
                          ));
                    },
                    childCount: _count + 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(100, 5, 100, 5),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2, //阴影范围
                  spreadRadius: 1, //阴影浓度
                  color: Colors.grey, //阴影颜色
                ),
              ],
            ),
            child: GNav(
              // rippleColor: Colors.grey[800], // tab button ripple color when pressed
              // hoverColor: Colors.grey[700], // tab button hover color
              haptic: true,
              // haptic feedback
              tabBorderRadius: 15,
              // tabActiveBorder: Border.all(color: Colors.black, width: 1),
              // tab button border
              // tabBorder: Border.all(color: Colors.grey, width: 1),
              // tab button border
              // tabShadow: [
              //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              // ],
              // tab button shadow
              curve: Curves.easeOutExpo,
              // tab animation curves
              duration: const Duration(milliseconds: 600),
              gap: 8,
              // the tab button gap between icon and text
              color: Colors.grey[800],
              // unselected icon color
              activeColor: Colors.purple,
              // selected icon and text color
              iconSize: 24,
              // tab button icon size
              tabBackgroundColor: Colors.purple.withOpacity(0.1),
              // selected tab background color
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              // navigation bar padding
              tabs: const [
                GButton(
                  icon: Icons.local_fire_department,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Follow',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  if (index == 0) {
                    _dataSrc = "/idea/get_idea_list";
                  } else if (index == 1) {
                    _dataSrc = "/idea/get_follow_idea_list";
                  }
                  getIdeaList(false);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
