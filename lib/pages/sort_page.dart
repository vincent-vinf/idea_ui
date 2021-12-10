import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';
import 'package:getwidget/components/tabs/gf_tabs.dart';
import 'package:idea/entity/sort.dart';
import 'package:idea/pages/idea_sort.dart';

class SortPage extends StatefulWidget {
  const SortPage({Key? key}) : super(key: key);

  @override
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> with TickerProviderStateMixin {
  late TabController tabController;
  List tabs = ["推荐标签", "全部分类", "标签活动", "正在寻找"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    // tabController.addListener(() {
    //   if(tabController.indexIsChanging){
    //     print("ysl--${tabController.index}");
    //   }
    //
    //   if(tabController.index.toDouble() == tabController.animation!.value){
    //     print("ysl${tabController.index}");
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "关注的标签",
            style: TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
          Container(
            height: 150.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(4.0),
                  child: IdeaSort(
                    sort: Sort("1", "1"),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(4.0),
                  child: IdeaSort(
                    sort: Sort("1", "1"),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(4.0),
                  child: IdeaSort(
                    sort: Sort("1", "1"),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(4.0),
                  child: IdeaSort(
                    sort: Sort("1", "1"),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: const [
                  Tab(
                    child: Text(
                      "推荐标签",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "全部分类",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "标签活动",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "正在寻找",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 400,
                child: TabBarView(
                  controller: tabController,
                  // children: [
                  //   SizedBox(
                  //     child: Text("data"),
                  //     height: 100,
                  //   ),
                  //   SizedBox(
                  //     child: Text("data"),
                  //     height: 100,
                  //   ),
                  //   SizedBox(
                  //     child: Text("data"),
                  //     height: 100,
                  //   ),
                  //   SizedBox(
                  //     child: Text("data"),
                  //     height: 100,
                  //   ),
                  // ],
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(4.0),
                                  child: IdeaSort(
                                    sort: Sort("1", "1"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(4.0),
                                  child: IdeaSort(
                                    sort: Sort("1", "1"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(4.0),
                                  child: IdeaSort(
                                    sort: Sort("1", "1"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(4.0),
                                  child: IdeaSort(
                                    sort: Sort("1", "1"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text("页面A"),
                    ),
                    Center(
                      child: Text("页面A"),
                    ),
                    Center(
                      child: Text("页面A"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
