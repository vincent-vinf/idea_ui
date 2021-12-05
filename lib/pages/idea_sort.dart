import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/sort.dart';

class IdeaSort extends StatefulWidget{
  final Sort sort;
  const IdeaSort({Key? key,required this.sort}) : super(key: key);

  @override
  _IdeaSortState createState() => _IdeaSortState();
  


}

class _IdeaSortState extends State<IdeaSort> {
  @override
  Widget build(BuildContext context) {
    return const GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      showOverlayImage: true,
      imageOverlay: AssetImage("assets/image/test.jpg"),
      title: GFListTile(
        titleText: "有价值的坏结果",
      ),
    );
  }
  
}