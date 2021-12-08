import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/space_header.dart';

import 'idea_info.dart';

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

  Future<void> getIdeaList(bool isLoad) async {
    if (!isLoad) _count = 0;
    final re = await post("/idea/get_idea_list",
        {"page": (_count ~/ _pageSize) + 1, "pageSize": _pageSize});
    int cnt = 0;
    List<Idea> tmp = [];
    if (isLoad && _total <= _count) {
      Fluttertoast.showToast(
          msg: "没有更多啦!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    if (re.statusCode == 200 && re.data["code"] == 0) {
      cnt = re.data["data"]["num"];
      for (int i = 0; i < cnt; i++) {
        tmp.add(json2Idea(re.data["data"]["list"][i]));
      }
      _total = re.data["data"]["total"];
      setState(() {
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
      appBar: AppBar(
        title: const Text("idea"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        elevation: 50.0,
      ),
      body: Container(
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
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IdeaInfo(id: items[index].id),
                        ));
                      },
                      child: IdeaCard(
                        idea: items[index],
                        isMarkdown: false,
                        func: (int id) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IdeaInfo(id: items[index].id,withComment: true,),
                          ));
                        },
                      ));
                },
                childCount: _count,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
