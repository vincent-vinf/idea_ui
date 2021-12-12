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
            style: TextStyle(color: Colors.grey, fontSize: 17.0),
          ),
          Container(
            height: 170.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(10.0),
                  child: IdeaSort(
                    sort: Sort("军事", "assets/image/sort/military.png"),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(10.0),
                  child: IdeaSort(
                    sort: Sort("体育", "assets/image/sort/sports.png"),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(10.0),
                  child: IdeaSort(
                    sort: Sort("社会", "assets/image/sort/social.png"),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 150.0,
                  margin: const EdgeInsets.all(10.0),
                  child: IdeaSort(
                    sort: Sort("科技", "assets/image/sort/technology.png"),
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
                      "热门分类",
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
                height: 900,
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
                                  margin: const EdgeInsets.all(10.0),
                                  child: IdeaSort(
                                    sort: Sort("科技", "assets/image/sort/technology.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(10.0),
                                  child: IdeaSort(
                                    sort: Sort("灾难", "assets/image/sort/disaster.png"),
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
                                  margin: const EdgeInsets.all(10.0),
                                  child: IdeaSort(
                                    sort: Sort("教育", "assets/image/sort/education.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(10.0),
                                  child: IdeaSort(
                                    sort: Sort("社会", "assets/image/sort/social.png"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
                                  margin: const EdgeInsets.all(10.0),
                                  child: IdeaSort(
                                    sort: Sort("体育", "assets/image/sort/sports.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(10.0),
                                  child: IdeaSort(
                                    sort: Sort("军事", "assets/image/sort/military.png"),
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
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("娱乐", "assets/image/sort/entertainment.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("政治", "assets/image/sort/political.png"),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("教育", "assets/image/sort/education.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("灾难", "assets/image/sort/disaster.png"),
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
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("社会", "assets/image/sort/social.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("科技", "assets/image/sort/technology.png"),
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
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("财经", "assets/image/sort/business.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 200.0,
                                  height: 150.0,
                                  margin: const EdgeInsets.all(8.0),
                                  child: IdeaSort(
                                    sort: Sort("违法", "assets/image/sort/illegal.png"),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
