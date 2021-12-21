import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:idea/entity/sort.dart';
import 'package:idea/pages/sort_info.dart';

class IdeaSort extends StatefulWidget {
  final Sort sort;

  const IdeaSort({Key? key, required this.sort}) : super(key: key);

  @override
  _IdeaSortState createState() => _IdeaSortState();
}

class _IdeaSortState extends State<IdeaSort> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SortInfo(sort: widget.sort,),
        ));
      },
      child: SizedBox(
        // height: flag?null:this.height,
        height: 140,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      widget.sort.img,
                      fit: BoxFit.cover,
                      height: 140,
                      width: double.infinity,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    )
                  ],
                )),
            Center(
              child: Text(widget.sort.content,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
