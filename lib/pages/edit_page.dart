import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea/util/request.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:markdown_widget/markdown_widget.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final FlipCardController _flipController = FlipCardController();
  final TextEditingController _textController = TextEditingController();

  String _data = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> publicIdea() async {
    if(_data.length<8){
      Fluttertoast.showToast(
          msg: "idea太短",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    try {
      final re = await post("/idea/create_idea", {"content": _data});
      if (re.statusCode == 200 && re.data["code"] == 0) {
        Fluttertoast.showToast(
            msg: "发布idea成功",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "发布idea失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          TextButton(
            onPressed: publicIdea,
            child: Text("发布"),
          ),
        ],
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
                (String value) => setState(() => _data = value),
                _data,
                label: 'Record your novel ideas here',
                maxLines: 10,
                actions: MarkdownType.values,
                controller: _textController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
