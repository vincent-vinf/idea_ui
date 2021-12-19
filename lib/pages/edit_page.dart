import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea/entity/idea.dart';
import 'package:idea/pages/idea_card.dart';
import 'package:idea/util/request.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'idea_info.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final FlipCardController _flipController = FlipCardController();
  final TextEditingController _textController = TextEditingController();
  List<Idea> similarIdeas = [];
  DateTime _preRefreshTime = DateTime.now();
  String _data = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> publicIdea() async {
    if (_data.length < 8) {
      Fluttertoast.showToast(
        msg: "idea太短",
      );
      return;
    }
    try {
      final re = await post("/idea/create_idea", {"content": _data});
      if (re.statusCode == 200) {
        if (re.data["code"] == 0) {
          Fluttertoast.showToast(
            msg: "发布idea成功",
          );
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
            msg: "发布idea失败",
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "发布idea失败",
      );
    }
  }

  Future<void> refreshSimilarIdeas() async {
    // setState(() {
    //   similarIdeas = [Idea.blankIdea, Idea.blankIdea, Idea.blankIdea];
    // });
    // return;
    final re = await post("/idea/get_similar_ideas", {"text": _data});
    if (re.statusCode == 200 && re.data["code"] == 0) {
      if (re.data["data"] != null) {
        final List<Idea> tmp = [];
        for (var i in (re.data["data"] as List)) {
          Idea t = json2Idea(i);
          tmp.add(t);
        }

        setState(() {
          similarIdeas = tmp;
        });
      }
    }
  }

  Widget similarIdeasWidget() {
    final customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
        .addRotate([-25.0 / 180, 0.0, 25.0 / 180]).addTranslate([
      const Offset(-150.0, 0.0),
      const Offset(0.0, 0.0),
      const Offset(150.0, 0.0)
    ]);

    int _currentIndex = 0;

    return Swiper(
      onTap: (int index) {
        print(index);
      },
      customLayoutOption: customLayoutOption,
      // fade: _fade,
      index: _currentIndex,
      onIndexChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      curve: Curves.ease,
      scale: 0.8,
      itemWidth: 800.0,
      // controller: _controller,
      layout: SwiperLayout.TINDER,
      outer: true,
      itemHeight: 270.0,
      // viewportFraction: _viewportFraction,
      // autoplayDelay: _autoplayDelay,
      // loop: _loop,
      // autoplay: _autoplay,
      itemBuilder: _buildIdeaCard,
      itemCount: similarIdeas.length,
      scrollDirection: Axis.horizontal,
      indicatorLayout: PageIndicatorLayout.COLOR,
    );
  }

  Widget _buildIdeaCard(BuildContext context, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => IdeaInfo(idea: similarIdeas[index]),
            ));
          },
          child: IdeaCard(
            idea: similarIdeas[index],
            isMarkdown: false,
            disableLike: false,
            fixHeight: 88,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
              child: ElevatedButton(
                onPressed: publicIdea,
                child: const Text("发布"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35))),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _flipController.toggleCard();
        },
        child: const Icon(Icons.find_replace),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: FlipCard(
              controller: _flipController,
              fill: Fill.fillBack,
              flipOnTouch: false,
              direction: FlipDirection.HORIZONTAL,
              back: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, //边框颜色
                      width: 1, //边框宽度
                    ), // 边色与边宽度
                    color: Colors.white, // 底色
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2, //阴影范围
                        spreadRadius: 1, //阴影浓度
                        color: Colors.grey, //阴影颜色
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12), // 圆角也可控件一边圆角大小
                    //borderRadius: BorderRadius.only(
                    //  topRight: Radius.circular(10),
                    // bottomRight: Radius.circular(10)) //单独加某一边圆角
                  ),
                  child: MarkdownWidget(
                    data: _data == "" ? "Here is empty" : _data,
                  )),
              front: MarkdownTextInput(
                (String value) {
                  _data = value;

                  if (_data.length >= 8 &&
                      // _data.length != value.length &&
                      DateTime.now()
                              .difference(_preRefreshTime)
                              .inMilliseconds >
                          1000) {
                    setState(() {
                      refreshSimilarIdeas();
                    });
                    _preRefreshTime = DateTime.now();
                  }
                },
                _data,
                label: 'Record your novel ideas here',
                maxLines: 12,
                actions: MarkdownType.values,
                controller: _textController,
              ),
            ),
          ),
          similarIdeas.isNotEmpty ? similarIdeasWidget() : Container(),
        ],
      ),
    );
  }
}
