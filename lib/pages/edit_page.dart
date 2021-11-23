import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
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

  String _data = "123";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.find_replace,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text("New route"),
        actions: [
          TextButton(
            onPressed: () {},
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
          FlipCard(
            controller: _flipController,
            fill: Fill.fillBack,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            back: Container(
              child: MarkdownWidget(data: _data),
              color: Colors.blueGrey,
            ),
            front: MarkdownTextInput(
              (String value) => setState(() => _data = value),
              _data,
              label: 'Description',
              maxLines: 10,
              actions: MarkdownType.values,
              controller: _textController,
            ),
          ),
        ],
      ),
    );
  }
}
