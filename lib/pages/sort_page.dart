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

class _SortPageState extends State<SortPage> {
  int _count = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: new content(),
    );
  }
}

// class content extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new contentState();
// }

// class contentState extends State<content> with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     tabController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TabBar(
//               length: 4,
//               controller: tabController,
//               isScrollable: true,
//               tabs: [
//                 Tab(
//                   child: Text(
//                     "推荐标签",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     "全部分类",
//                     style: TextStyle(color: Colors.grey, fontSize: 20.0),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     "标签活动",
//                     style: TextStyle(color: Colors.grey, fontSize: 20.0),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     "正在寻找",
//                     style: TextStyle(color: Colors.grey, fontSize: 20.0),
//                   ),
//                 ),
//               ],
//             ),
//             GFTabBarView(
//               controller: tabController,
//               children: [
//                 Container(
//                   child: Text("推荐标签"),
//                 ),
//                 Container(
//                   child: Text("全部分类"),
//                 ),
//                 Container(
//                   child: Text("标签活动"),
//                 ),
//                 Container(
//                   child: Text("正在寻找"),
//                 )
//               ],
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }

class content extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new contentState();
}

class contentState extends State<content> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List tabs = ["推荐标签", "全部分类", "标签活动", "正在寻找"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    print(tabController.length);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("idea"),
        backgroundColor: Colors.blue,
        elevation: 50.0,
      ),
      body: buildDemo(),
    );
  }

  Widget buildDemo() {
    return SingleChildScrollView(

      child: Column(
          children: [
            Container(
              height: 20.0,
              child: Text("关注的标签",style: TextStyle(color: Colors.grey, fontSize: 15.0),),
            ),
            Container(
              height: 150.0,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                          Expanded(
                              child: Container(
                                width: 200.0,
                                height: 150.0,
                                margin: const EdgeInsets.all(4.0),
                                child: IdeaSort(
                                  sort: Sort("1", "1"),
                                ),
                              )
                          ),
                          Expanded(
                              child: Container(
                                width: 200.0,
                                height: 150.0,
                                margin: const EdgeInsets.all(4.0),
                                child: IdeaSort(
                                  sort: Sort("1", "1"),

                                ),
                              )
                          ),
                      Expanded(
                          child: Container(
                            width: 200.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(4.0),
                            child: IdeaSort(
                              sort: Sort("1", "1"),

                            ),
                          )
                      ),
                      Expanded(
                          child: Container(
                            width: 200.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(4.0),
                            child: IdeaSort(
                              sort: Sort("1", "1"),

                            ),
                          )
                      )
                    ]
                )
            ),

            // const Text(
            //   '关注的标签',
            //   style: TextStyle(color: Colors.grey, fontSize: 20.0),
            // ),
            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         Expanded(
            //             child: Container(
            //               width: 200.0,
            //               height: 150.0,
            //               margin: const EdgeInsets.all(4.0),
            //               child: IdeaSort(
            //                 sort: Sort("1", "1"),
            //               ),
            //             )),
            //         Expanded(
            //             child: Container(
            //                 width: 200.0,
            //                 height: 150.0,
            //                 margin: const EdgeInsets.all(4.0),
            //                 child: IdeaSort(
            //                   sort: Sort("1", "1"),
            //                 )))
            //       ],
            //     ),
            // SingleChildScrollView(
            //   child:

            Container(
                height: 200.0,
                child:
                Column(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 100.0,
                              child: TabBar(
                                controller: tabController,
                                isScrollable: true,
                                tabs: const [
                                  Tab(
                                    child: Text("推荐标签", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),),
                                  ),
                                  Tab(
                                    child: Text("全部分类", style: TextStyle(
                                        color: Colors.grey, fontSize: 20.0),),
                                  ),
                                  Tab(
                                    child: Text("标签活动", style: TextStyle(
                                        color: Colors.grey, fontSize: 20.0),),
                                  ),
                                  Tab(
                                    child: Text("正在寻找", style: TextStyle(
                                        color: Colors.grey, fontSize: 20.0),),
                                  )
                                ],
                              )
                          )
                      ),
                      Expanded(
                          child: SizedBox(
                              // height: 500.0,
                              child: TabBarView(
                                controller: tabController,
                                children: <Widget>[
                                  Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                                  width: 200.0,
                                                  height: 150.0,
                                                  margin: const EdgeInsets.all(
                                                      4.0),
                                                  child: IdeaSort(
                                                    sort: Sort("1", "1"),),

                                                )
                                            ),
                                            Expanded(
                                                child: Container(
                                                    width: 200.0,
                                                    height: 150.0,
                                                    margin: const EdgeInsets
                                                        .all(4.0),
                                                    child: IdeaSort(
                                                      sort: Sort("1", "1"),)
                                                )
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                                  width: 200.0,
                                                  height: 150.0,
                                                  margin: const EdgeInsets.all(
                                                      4.0),
                                                  child: IdeaSort(
                                                    sort: Sort("1", "1"),),

                                                )
                                            ),
                                            Expanded(
                                                child: Container(
                                                    width: 200.0,
                                                    height: 150.0,
                                                    margin: const EdgeInsets
                                                        .all(4.0),
                                                    child: IdeaSort(
                                                      sort: Sort("1", "1"),)
                                                )
                                            )
                                          ],
                                        ),
                                      ]
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
                              )

                            // )
                          )
                      ),
                    ]

                )
              // ]
            ),
            // )
          ]
      ),


      // Row(
      //
      //   children: [
      // new Expanded(
      //     child: new Text("推荐标签",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),)
      // ),
      // new Expanded(
      //     child: new Text("全部分类",style: TextStyle(color: Colors.grey,fontSize: 20.0),)
      // ),
      // new Expanded(
      //     child: new Text("标签活动",style: TextStyle(color: Colors.grey,fontSize: 20.0),)
      // ),
      // new Expanded(
      //     child: new Text("正在寻找",style: TextStyle(color: Colors.grey,fontSize: 20.0),)
      // )
      // Expanded(
      //   // child:SizedBox(
      //   //   height:200.0,
      //     child: TabBar(
      //   controller: tabController,
      //   isScrollable: true,
      //   // tabs:tabs.map((e) => Tab(text:e)).toList(),
      //   tabs: [
      //     Tab(
      //       text: "页面A",
      //     ),
      //     Tab(
      //       text: "页面B",
      //     ),
      //     Tab(
      //       text: "页面C",
      //     )
      //   ],
      // // )
      //   )
      // ),
      // Expanded(
      //   child:SizedBox(
      //     height: 200.0,
      //     child: TabBarView(
      //   controller: tabController,
      //   children: <Widget> [
      //     Center(
      //       child: Text("页面A"),
      //     ),
      //     Center(
      //       child: Text("页面A"),
      //     ),
      //     Center(
      //       child: Text("页面A"),
      //     )
      //   ],
      // children:  tabs.map((e){
      // return KeepAliveWrapper(
      // child: Container(
      // alignment: Alignment.center,
      // child: Text(e, textScaleFactor: 5),
      // ),
      // );
      // }).toList(),

      // tabs: <Widget> [
      //   Tab(
      //     child: Text("推荐标签",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
      //   ),
      //   Tab(
      //     child: Text("全部分类",style: TextStyle(color: Colors.grey,fontSize: 20.0),),
      //   ),
      //   Tab(
      //     child: Text("标签活动",style: TextStyle(color: Colors.grey,fontSize: 20.0),),
      //   ),
      //   Tab(
      //     child: Text("正在寻找",style: TextStyle(color: Colors.grey,fontSize: 20.0),),
      //   ),
      // ],
      //   tabBarView: GFTabBarView(
      //     controller: tabController,
      //     children: [
      //       Container(child: Text("推荐标签"),),
      //       Container(child: Text("全部分类"),),
      //       Container(child: Text("标签活动"),),
      //       Container(child: Text("正在寻找"),)
      //     ],
      //   ),
      // )

      //
      //     ),
      //   ],
      // ),
      // Row(
      //   children: [
      //     Expanded(
      //         child: Container(
      //           width: 200.0,
      //           height: 150.0,
      //           margin: const EdgeInsets.all(4.0),
      //           child: IdeaSort(sort: Sort("1","1"),),
      //
      //         )
      //     ),
      //     Expanded(
      //         child: Container(
      //             width: 200.0,
      //             height: 150.0,
      //             margin: const EdgeInsets.all(4.0),
      //             child: IdeaSort(sort: Sort("1","1"),)
      //         )
      //     )
      //   ],
      // ),
      // Row(
      //   children: [
      //     Expanded(
      //         child: Container(
      //           width: 200.0,
      //           height: 150.0,
      //           margin: const EdgeInsets.all(4.0),
      //           child: IdeaSort(sort: Sort("1","1"),),
      //
      //         )
      //     ),
      //     Expanded(
      //         child: Container(
      //             width: 200.0,
      //             height: 150.0,
      //             margin: const EdgeInsets.all(4.0),
      //             child: IdeaSort(sort: Sort("1","1"),)
      //         )
      //     )
      //   ],
      // ),
      // Row(
      //   children: [
      //     Expanded(
      //         child: Container(
      //           width: 200.0,
      //           height: 150.0,
      //           margin: const EdgeInsets.all(4.0),
      //           child: IdeaSort(sort: Sort("1","1"),),
      //
      //         )
      //     ),
      //     Expanded(
      //         child: Container(
      //             width: 200.0,
      //             height: 150.0,
      //             margin: const EdgeInsets.all(4.0),
      //             child: IdeaSort(sort: Sort("1","1"),)
      //             )
      // )

      // )
      // ],
      // )],
      //
      // )
      // ],
      // );
      // }
    );
  }
}
