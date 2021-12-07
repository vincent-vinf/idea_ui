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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const Text(
          '关注的标签',
          style: TextStyle(color: Colors.grey, fontSize: 20.0),
        ),
        Container(
          child: Column(
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
                  )),
                  Expanded(
                      child: Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: IdeaSort(
                            sort: Sort("1", "1"),
                          )))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "推荐标签",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  )),
                  Expanded(
                      child: Text(
                    "全部分类",
                    style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  )),
                  Expanded(
                      child: Text(
                    "标签活动",
                    style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  )),
                  Expanded(
                      child: Text(
                    "正在寻找",
                    style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  ))
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
                  )),
                  Expanded(
                      child: Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: IdeaSort(
                            sort: Sort("1", "1"),
                          )))
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
                  )),
                  Expanded(
                      child: Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: IdeaSort(
                            sort: Sort("1", "1"),
                          )))
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
                  )),
                  Expanded(
                      child: Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: IdeaSort(
                            sort: Sort("1", "1"),
                          )))
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
                  )),
                  Expanded(
                      child: Container(
                          width: 200.0,
                          height: 150.0,
                          margin: const EdgeInsets.all(4.0),
                          child: IdeaSort(
                            sort: Sort("1", "1"),
                          )))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
