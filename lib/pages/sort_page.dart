import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: new content(),
      );

  }

}
class content extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new contentState();

}
class contentState extends State<content>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:AppBar(
        title: const Text("idea"),
        backgroundColor: Colors.blue,
        elevation: 50.0,
      ),
      body: buildDemo(),
    );
  }
  Widget buildDemo(){
    return new SingleChildScrollView(

      child: Column(

        children: [
          Text('关注的标签',style: TextStyle(color: Colors.grey,fontSize: 20.0),),
          Container(
            child: new Column(

              children: [
                new Row(
                  children: [
                    new Expanded(
                        child: new Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: new IdeaSort(sort: Sort("1","1"),),

                        )
                    ),
                    new Expanded(
                        child: new Container(
                            width: 200.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(4.0),
                            child: new IdeaSort(sort: Sort("1","1"),)
                        )
                    )
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                        child: new Text("推荐标签",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),)
                    ),
                    new Expanded(
                        child: new Text("全部分类",style: TextStyle(color: Colors.grey,fontSize: 20.0),)
                    ),
                    new Expanded(
                        child: new Text("标签活动",style: TextStyle(color: Colors.grey,fontSize: 20.0),)
                    ),
                    new Expanded(
                        child: new Text("正在寻找",style: TextStyle(color: Colors.grey,fontSize: 20.0),)
                    )
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                        child: new Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: new IdeaSort(sort: Sort("1","1"),),

                        )
                    ),
                    new Expanded(
                        child: new Container(
                            width: 200.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(4.0),
                            child: new IdeaSort(sort: Sort("1","1"),)
                        )
                    )
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                        child: new Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: new IdeaSort(sort: Sort("1","1"),),

                        )
                    ),
                    new Expanded(
                        child: new Container(
                            width: 200.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(4.0),
                            child: new IdeaSort(sort: Sort("1","1"),)
                        )
                    )
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                        child: new Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: new IdeaSort(sort: Sort("1","1"),),

                        )
                    ),
                    new Expanded(
                        child: new Container(
                            width: 200.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(4.0),
                            child: new IdeaSort(sort: Sort("1","1"),)
                        )
                    )
                  ],
                )
              ],
              
            ),
          )

        ],
      )


    );
  }



}
